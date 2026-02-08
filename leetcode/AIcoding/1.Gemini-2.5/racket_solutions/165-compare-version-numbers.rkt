(define (compare-version version1 version2)
  (define (parse-version s)
    (map string->number (string-split s ".")))

  (define (compare-parts p1 p2)
    (cond
      [(and (empty? p1) (empty? p2)) 0]
      [else
       (define h1 (if (empty? p1) 0 (car p1)))
       (define h2 (if (empty? p2) 0 (car p2)))
       (cond
         [(< h1 h2) -1]
         [(> h1 h2) 1]
         [else (compare-parts (if (empty? p1) '() (cdr p1))
                              (if (empty? p2) '() (cdr p2)))])]))

  (compare-parts (parse-version version1) (parse-version version2)))