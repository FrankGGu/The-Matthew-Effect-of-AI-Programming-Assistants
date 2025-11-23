#lang racket

(define (solution n k)
  (define MOD 1000000007)

  (define dp (make-vector (+ n 1)))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ k 1) 0)))

  (for ([j (in-range 1 (+ k 1))])
    (vector-set! (vector-ref dp 1) j j))

  (for ([i (in-range 2 (+ n 1))])
    (for ([current-val (in-range 1 (+ k 1))])
      (for ([prev-val (in-range 1 (+ current-val 1))])
        (let ([prev-sum-prod (vector-ref (vector-ref dp (- i 1)) prev-val)])
          (when (> prev-sum-prod 0)
            (let ([new-sum-prod (modulo (* prev-sum-prod current-val) MOD)])
              (vector-set! (vector-ref dp i) current-val
                           (modulo (+ (vector-ref (vector-ref dp i) current-val) new-sum-prod) MOD))))))))

  (define total-sum 0)
  (for ([j (in-range 1 (+ k 1))])
    (set! total-sum (modulo (+ total-sum (vector-ref (vector-ref dp n) j)) MOD)))

  total-sum)