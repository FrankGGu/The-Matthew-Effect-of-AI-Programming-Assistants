(define (count-prefix-suffix-pairs words)
  (define (is-prefix? prefix word)
    (and (<= (string-length prefix) (string-length word))
         (string=? (substring word 0 (string-length prefix)) prefix)))

  (define (is-suffix? suffix word)
    (and (<= (string-length suffix) (string-length word))
         (string=? (substring word (- (string-length word) (string-length suffix))) suffix)))

  (define (count-pairs acc words)
    (for ([i (in-range (length words))])
      (for ([j (in-range (length words))])
        (when (and (not (= i j))
                   (or (is-prefix? (list-ref words i) (list-ref words j))
                       (is-suffix? (list-ref words i) (list-ref words j))))
          (set! acc (+ acc 1)))))
    acc)

  (count-pairs 0 words))

(define (countPrefixesSuffixes words)
  (count-prefix-suffix-pairs words))