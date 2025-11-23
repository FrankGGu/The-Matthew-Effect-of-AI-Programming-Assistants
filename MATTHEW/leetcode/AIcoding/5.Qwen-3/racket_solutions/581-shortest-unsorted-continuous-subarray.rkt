(define (shortest-unsorted-continuous-subarray nums)
  (define n (length nums))
  (define-values (left right)
    (let loop ([i 0] [j (- n 1)] [min-val +inf.0] [max-val -inf.0] [l 0] [r -1])
      (cond
        [(> i j) (values l r)]
        [else
         (let ([current (list-ref nums i)])
           (if (> current max-val)
               (loop (+ i 1) j min-val current l j)
               (loop (+ i 1) j min-val max-val l r)))
         (let ([current (list-ref nums j)])
           (if (< current min-val)
               (loop i (- j 1) current max-val l r)
               (loop i (- j 1) min-val max-val l r)))])))
  (- right left 1))