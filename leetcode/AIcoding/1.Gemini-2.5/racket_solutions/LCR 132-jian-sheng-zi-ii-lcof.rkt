#lang racket

(define (solve bamboo-lengths k)
  (let* ([n (length bamboo-lengths)]
         [bamboo-lengths-vec (list->vector bamboo-lengths)]
         [max-bamboo-len (if (zero? n) 0 (apply max bamboo-lengths))]
         [max-prod (make-vector (+ max-bamboo-len 1))])

    (for ([l (in-range (+ max-bamboo-len 1))])
      (vector-set! max-prod l (make-vector (+ k 1))))

    (for ([l (in-range (+ max-bamboo-len 1))])
      (vector-set! (vector-ref max-prod l) 0 1))

    (for ([p (in-range 1 (+ k 1))])
      (for ([l (in-range 1 (+ max-bamboo-len 1))])
        (cond
          [(< l p)
           (vector-set! (vector-ref max-prod l) p 0)]
          [else
           (let* ([q (quotient l p)]
                  [r (remainder l p)])
             (vector-set! (vector-ref max-prod l) p
                          (* (expt (+ q 1) r) (expt q (- p r)))))])))

    (let ([dp (make-vector (+ n 1))])
      (for ([i (in-range (+ n 1))])
        (vector-set! dp i (make-vector (+ k 1))))

      (vector-set! (vector-ref dp 0) 0 1)

      (for ([j (in-range 1 (+ k 1))])
        (vector-set! (vector-ref dp 0) j 0))

      (for ([i (in-range 1 (+ n 1))])
        (let ([current-bamboo-len (vector-ref bamboo-lengths-vec (- i 1))])
          (for ([j (in-range (+ k 1))])
            (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1)) j))

            (for ([p (in-range 1 (+ j 1))])
              (let ([prev-j (- j p)])
                (when (> (vector-ref (vector-ref dp (- i 1)) prev-j) 0)
                  (let ([product-from-current (vector-ref (vector-ref max-prod current-bamboo-len) p)])
                    (when (> product-from-current 0)
                      (vector-set! (vector-ref dp i) j
                                   (max (vector-ref (vector-ref dp i) j)
                                        (* (vector-ref (vector-ref dp (- i 1)) prev-j)
                                           product-from-current)))))))))))

      (vector-ref (vector-ref dp n) k))))