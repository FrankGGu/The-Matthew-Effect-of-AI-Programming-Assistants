(define (find-almost-equal-substring s)
  (define (is-almost-equal? a b)
    (and (= (string-length a) (string-length b))
         (not (equal? a b))))
  (define (helper start)
    (for/fold ([first-equal #f]) ([i (in-range start (string-length s))])
      (for ([j (in-range (+ i 1) (string-length s))])
        (when (is-almost-equal? (substring s start i) (substring s start j))
          (if first-equal
              first-equal
              (substring s start j))))))
  (for ([i (in-range (string-length s))])
    (let ([result (helper i)])
      (when result
        (return result)))))