(define (min-subsequence nums)
  (let* ([sorted-nums (sort nums (lambda (a b) (> a b)))] ; Sort in non-increasing order
         [total-sum (foldl + 0 sorted-nums)])
    (let loop ([remaining-nums sorted-nums]
               [current-subsequence-reversed '()]
               [current-subsequence-sum 0])
      (let ([current-element (car remaining-nums)])
        (let* ([new-subsequence-reversed (cons current-element current-subsequence-reversed)]
               [new-subsequence-sum (+ current-subsequence-sum current-element)])
          (if (> new-subsequence-sum (- total-sum new-subsequence-sum))
              (reverse new-subsequence-reversed)
              (loop (cdr remaining-nums)
                    new-subsequence-reversed
                    new-subsequence-sum)))))))