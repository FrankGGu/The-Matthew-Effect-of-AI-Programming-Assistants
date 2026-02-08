(define (count-repetitions s1 n1 s2 n2)
  (define (repeat-string s n)
    (string-append* (make-list n s)))

  (define (count-occurrences long short)
    (define (count-helper long short count)
      (cond
        [(string=? long "") count]
        [(string-prefix? long short) (count-helper (substring long (string-length short)) short (+ count 1))]
        [else (count-helper (substring long 1) short count)]))
    (count-helper long short 0))

  (define long (repeat-string s1 n1))
  (define short (repeat-string s2 n2))

  (floor (/ (count-occurrences long s2) n2)))