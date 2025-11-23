(define (count-prefixes words s)
  (define (is-prefix? word)
    (and (<= (string-length word) (string-length s))
         (string=? (substring s 0 (string-length word)) word)))
  (length (filter is-prefix? words)))

(define (num-times-prefix-aligned words s)
  (count-prefixes words s))