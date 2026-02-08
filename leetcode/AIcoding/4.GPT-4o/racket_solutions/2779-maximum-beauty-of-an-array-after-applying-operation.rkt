(define (maximum-beauty nums k)
  (define sorted-nums (sort nums <))
  (define (calc-beauty left right)
    (if (>= right (length sorted-nums))
        0
        (let* ((min-val (list-ref sorted-nums left))
               (max-val (list-ref sorted-nums right))
               (current-beauty (+ 1 (- max-val min-val))))
          (max current-beauty (calc-beauty left (+ right 1))))))
  (calc-beauty 0 0))

(maximum-beauty nums k)