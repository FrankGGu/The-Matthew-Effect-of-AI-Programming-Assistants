(define (minNumStrings(words target)
  (define (count-char s)
    (foldl (lambda (c acc) (hash-update! acc c (lambda (x) (if x (+ x 1) 1)) 0))
           (make-hash)
           s))

  (define target-count (count-char target))

  (define (can-form? word target-count)
    (define word-count (count-char word))
    (for/fold ([can #t]) ([c (hash->list target-count)])
      (if (hash-has? word-count (car c))
          (and can (<= (cdr c) (hash-ref word-count (car c))))
          #f)))

  (define (backtrack start acc)
    (if (and (> acc 0) (equal? (count-char (apply string-append (take words acc))) target-count))
        1
        (for/fold ([min-strings (if (> acc 0) + 0)]) ([i (in-range start (length words))])
          (if (can-form? (list-ref words i) target-count)
              (min min-strings (backtrack (add1 i) (add1 acc)))
              min-strings))))

  (define result (backtrack 0 0))
  (if (= result 0) -1 result))

(minNumStrings '("abc" "ab" "c" "a" "b" "bc") "abcabc")