(define (max-sum-two-non-overlapping nums firstLen secondLen)
  (let* ((n (length nums))
         (P (make-vector (+ n 1) 0)))

    (for/fold ([current-sum 0] #:result (void))
              ([i (in-range n)]
               [val (in-list nums)])
      (vector-set! P (+ i 1) (+ current-sum val))
      (+ current-sum val))

    (define (find-max-sum-L-before-M L M)
      (let ([max-total-sum 0])
        (for ([i (in-range (- L 1) (- n M))])
          (let* ([current-L-sum (- (vector-ref P (+ i 1)) (vector-ref P (- (+ i 1) L)))]
                 [max-M-sum-after-L 0])
            (for ([j (in-range (+ i 1) (- n M -1))])
              (let ([current-M-sum (- (vector-ref P (+ j M)) (vector-ref P j))])
                (set! max-M-sum-after-L (max max-M-sum-after-L current-M-sum))))
            (set! max-total-sum (max max-total-sum (+ current-L-sum max-M-sum-after-L)))))
        max-total-sum))

    (max (find-max-sum-L-before-M firstLen secondLen)
         (find-max-sum-L-before-M secondLen firstLen))))