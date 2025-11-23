(define (longest-common-suffix-queries words queries)
  (define (lcs s1 s2)
    (let loop ([i (- (string-length s1) 1)] [j (- (string-length s2) 1)])
      (cond
        [(or (< i 0) (< j 0)) ""]
        [(char=? (string-ref s1 i) (string-ref s2 j))
         (string-append (loop (- i 1) (- j 1)) (string (string-ref s1 i)))]
        [else ""])))

  (map (lambda (q) (lcs (list-ref words (car q)) (list-ref words (cadr q)))) queries))