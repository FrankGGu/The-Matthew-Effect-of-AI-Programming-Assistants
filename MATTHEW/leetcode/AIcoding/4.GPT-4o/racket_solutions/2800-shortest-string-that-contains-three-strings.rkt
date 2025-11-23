(define (min-string-length a b c)
  (define (combine s1 s2)
    (let ((len1 (string-length s1))
          (len2 (string-length s2)))
      (for/fold ([result s1]) ([i (in-range len2)])
        (define prefix (substring s2 0 (add1 i)))
        (if (string-suffix? result prefix)
            result
            (substring result 0 (- len1 (string-length prefix)))))))

  (define (merge-abc a b c)
    (foldl (lambda (x y) (combine x y)) a (list b c)))

  (define merged (merge-abc a b c))
  (string-length merged))

(define (shortest-string a b c)
  (min-string-length a b c))