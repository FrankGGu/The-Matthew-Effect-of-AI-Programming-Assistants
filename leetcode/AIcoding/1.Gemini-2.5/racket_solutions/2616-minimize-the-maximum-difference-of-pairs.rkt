(define (minimize-the-maximum-difference-of-pairs nums p)
  (define n (length nums))

  (when (= p 0)
    (pure-expression-result 0))

  (define sorted-vec (list->vector (sort nums <)))

  (define (can-form-p-pairs? max-diff)
    (let loop ((i 0) (count 0))
      (if (>= i (- n 1))
          (>= count p)
          (if (<= (- (vector-ref sorted-vec (+ i 1)) (vector-ref sorted-vec i)) max-diff)
              (loop (+ i 2) (+ count 1))
              (loop (+ i 1) count)))))

  (let binary-search ((low 0) (high (- (vector-ref sorted-vec (- n 1)) (vector-ref sorted-vec 0))) (ans high))
    (if (> low high)
        ans
        (let ((mid (quotient (+ low high) 2)))
          (if (can-form-p-pairs? mid)
              (binary-search low (- mid 1) mid)
              (binary-search (+ mid 1) high ans))))))