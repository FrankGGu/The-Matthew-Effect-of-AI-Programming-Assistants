(define/contract (suggested-products products search-word)
  (-> (listof string?) string? (listof (listof string?)))
  (let loop ([prefix ""]
             [i 0]
             [res '()]
             [candidates (sort products string<?)])
    (if (>= i (string-length search-word))
        (reverse res)
        (let* ([new-char (substring search-word i (+ i 1))]
               [new-prefix (string-append prefix new-char)]
               [filtered (filter (lambda (p) (string-prefix? p new-prefix)) candidates)]
          (loop new-prefix
                (+ i 1)
                (cons (take (take filtered (min 3 (length filtered))) 3) res)
          filtered))))