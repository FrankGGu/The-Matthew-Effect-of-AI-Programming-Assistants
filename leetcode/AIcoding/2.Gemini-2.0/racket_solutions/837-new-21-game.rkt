(define (new21-game n k max-pts)
  (if (>= k n)
      1.0
      (let ([dp (make-vector (+ n 1) 0.0)])
        (vector-set! dp n 1.0)
        (let loop ([i (- n 1)] [sum (if (<= n (+ k max-pts)) 1.0 0.0)])
          (if (< i k)
              (vector-set! dp i (/ sum max-pts))
              (vector-set! dp i 0.0))
          (if (= i 0)
              (vector-sum (vector->list (vector-slice dp 0 k)))
              (loop (- i 1) (- sum (- (vector-ref dp (+ i max-pts)) (vector-ref dp i))))))))

(define (vector-sum v)
  (foldl + 0.0 v))

(define (vector-slice v start end)
  (list->vector (list-tail (vector->list v) start end)))