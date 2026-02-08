#lang racket

(define (solve nums m)
  (let* ([n (vector-length nums)])
    (cond
      [(< n m)
       (if (zero? m) 0 -inf.0)]
      [else
       (define prefix-sums (make-vector (+ n 1) 0))
       (for ([i (in-range n)])
         (vector-set! prefix-sums (+ i 1) (+ (vector-ref prefix-sums i) (vector-ref nums i))))

       (define max-so-far -inf.0)
       (define current-min-prefix-sum 0)

       (for ([j (in-range m (+ n 1))])
         (set! current-min-prefix-sum (min current-min-prefix-sum (vector-ref prefix-sums (- j m))))
         (set! max-so-far (max max-so-far (- (vector-ref prefix-sums j) current-min-prefix-sum)))
         )
       max-so-far])))