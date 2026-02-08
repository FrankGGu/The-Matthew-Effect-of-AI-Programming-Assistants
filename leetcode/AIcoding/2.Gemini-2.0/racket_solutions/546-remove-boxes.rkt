(define (remove-boxes boxes)
  (define n (length boxes))
  (define memo (make-hash))

  (define (solve l r k)
    (let ([key (cons l (cons r k))])
      (if (hash-has-key? memo key)
          (hash-ref memo key)
          (let loop ([l l] [r r] [k k])
            (cond
              [(< l r)
               (if (= (list-ref boxes l) (list-ref boxes (+ r -1)))
                   (loop l (- r 1) (+ k 1))
                   (let ([res (+ (* k k) (solve l r 0))])
                     (for ([i (in-range l r)])
                       (when (= (list-ref boxes i) (list-ref boxes l))
                         (set! res (max res (+ (solve (+ l 1) i 0) (solve i r (+ k 1))))))
                     (hash-set! memo key res)
                     res))]
              [(= l r)
               (hash-set! memo key (* k k))
               (* k k)]
              [else
               (hash-set! memo key 0)
               0]))))))

  (solve 0 n 0))