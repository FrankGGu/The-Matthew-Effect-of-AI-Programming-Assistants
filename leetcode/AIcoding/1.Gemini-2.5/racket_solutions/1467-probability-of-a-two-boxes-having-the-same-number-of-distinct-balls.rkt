(require racket/hash)

(define (combinations n k)
  (cond
    ((< k 0) 0)
    ((> k n) 0)
    ((or (= k 0) (= k n)) 1)
    ((= k 1) n)
    (else
     (let ([k (min k (- n k))])
       (let loop ([i 1] [res 1])
         (if (> i k)
             res
             (loop (+ i 1) (/ (* res (- n (- i 1))) i))))))))

(define (get-probability-of-two-boxes-having-the-same-number-of-distinct-balls balls)
  (let* ([N (vector-length balls)]
         [total-balls (apply + (vector->list balls))]
         [target-half (/ total-balls 2)]
         [memo (make-hash)])

    (define (solve idx b1-cnt b2-cnt b1-distinct b2-distinct)
      (let ([key (list idx b1-cnt b2-cnt b1-distinct b2-distinct)])
        (hash-ref! memo key
                   (lambda ()
                     (cond
                       ((= idx N)
                        (if (and (= b1-cnt target-half) (= b2-cnt target-half))
                            (if (= b1-distinct b2-distinct)
                                (cons 1 1)
                                (cons 0 1))
                            (cons 0 0)))
                       (else
                        (let* ([current-ball-type-count (vector-ref balls idx)]
                               [satisfied-sum 0]
                               [total-sum 0])
                          (for ([i (in-range (+ current-ball-type-count 1))])
                            (let* ([j (- current-ball-type-count i)]
                                   [new-b1-cnt (+ b1-cnt i)]
                                   [new-b2-cnt (+ b2-cnt j)])

                              (when (and (<= new-b1-cnt target-half)
                                         (<= new-b2-cnt target-half))
                                (let* ([new-b1-distinct (+ b1-distinct (if (> i 0) 1 0))]
                                       [new-b2-distinct (+ b2-distinct (if (> j 0) 1 0))]
                                       [num-ways-to-split-current-type (combinations current-ball-type-count i)]
                                       [sub-result (solve (+ idx 1) new-b1-cnt new-b2-cnt new-b1-distinct new-b2-distinct)])
                                  (set! satisfied-sum (+ satisfied-sum (* num-ways-to-split-current-type (car sub-result))))
                                  (set! total-sum (+ total-sum (* num-ways-to-split-current-type (cdr sub-result))))))))
                          (cons satisfied-sum total-sum)))))))

    (let* ([result (solve 0 0 0 0 0)]
           [satisfied-ways (car result)]
           [total-ways (cdr result)])
      (if (= total-ways 0)
          0.0
          (/ (exact->inexact satisfied-ways) (exact->inexact total-ways))))))