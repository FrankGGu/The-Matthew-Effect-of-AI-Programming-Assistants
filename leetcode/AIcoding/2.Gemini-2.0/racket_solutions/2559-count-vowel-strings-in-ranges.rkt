(define (count-vowel-strings-in-ranges words queries)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define (is-vowel-string? word)
    (and (set-member? vowels (string-ref word 0))
         (set-member? vowels (string-ref word (- (string-length word) 1)))))
  (define vowel-string-counts
    (for/fold ([acc '()]) ([word words])
      (cons (if (is-vowel-string? word) 1 0) acc)))
  (define prefix-sums
    (reverse
     (for/fold ([acc '()] [count (reverse vowel-string-counts)])
       (cons (+ count (if (null? acc) 0 (car acc))) acc))))

  (for/list ([query queries])
    (let ([start (car query)]
          [end (cadr query)])
      (- (list-ref prefix-sums end)
         (if (= start 0) 0 (list-ref prefix-sums (- start 1)))))))