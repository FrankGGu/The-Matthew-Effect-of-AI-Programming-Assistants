(define (max-subarray-min-product nums)
  (let* ([n (vector-length nums)]
         [prefix-sums (make-vector (+ n 1) 0)]
         [st '()]
         [max-prod 0])

    (for ([i (in-range 1 (+ n 1))])
      (vector-set! prefix-sums i (+ (vector-ref prefix-sums (- i 1))
                                    (vector-ref nums (- i 1)))))

    (for ([i (in-range (+ n 1))])
      (let ([current-val (if (< i n) (vector-ref nums i) 0)])
        (let loop-pop ()
          (when (and (not (empty? st))
                     (>= (vector-ref nums (car st)) current-val))
            (let* ([h (car st)])
              (set! st (cdr st))
              (let* ([left-boundary (if (empty? st) -1 (car st))]
                     [right-boundary i]
                     [current-sum (- (vector-ref prefix-sums right-boundary)
                                     (vector-ref prefix-sums (+ left-boundary 1)))]
                     [product (* (vector-ref nums h) current-sum)])
                (set! max-prod (max max-prod product))
                (loop-pop)))))
        (set! st (cons i st))))

    max-prod))