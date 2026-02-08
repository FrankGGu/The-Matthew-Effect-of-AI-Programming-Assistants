(define (generate-parenthesis n)
  (define result '())

  (define (backtrack current-string open-count close-count)
    (when (and (= open-count n) (= close-count n))
      (set! result (cons current-string result)))

    (when (< open-count n)
      (backtrack (string-append current-string "(") (add1 open-count) close-count))

    (when (< close-count open-count)
      (backtrack (string-append current-string ")") open-count (add1 close-count))))

  (backtrack "" 0 0)
  (reverse result))