(define (brace-expansion-ii s)
  (define (parse str)
    (define (helper i)
      (cond
        [(>= i (string-length str)) (values '() i)]
        [(char=? (string-ref str i) #\{)
         (let-values ([(options next-i) (parse (+ i 1))])
           (let-values ([(rest final-i) (helper next-i)])
             (values (append* (map (lambda (opt)
                                      (if (null? rest)
                                          (list opt)
                                          (map (lambda (r) (string-append opt r)) rest)))
                                    options))
                     final-i)))]
        [(char=? (string-ref str i) #\,)
         (let-values ([(rest final-i) (helper (+ i 1))])
           (values (cons '() rest) final-i))]
        [(char=? (string-ref str i) #\})
         (values '() (+ i 1))]
        [else
         (let ([j (let loop ([k i])
                    (cond
                      [(or (>= k (string-length str))
                           (char=? (string-ref str k) #\{)
                           (char=? (string-ref str k) #\,)
                           (char=? (string-ref str k) #\}))
                       k]
                      [else (loop (+ k 1))]))])
           (let ([word (substring str i j)])
             (let-values ([(rest final-i) (helper j)])
               (values (cons word rest) final-i))))]))
    (let-values ([(result _) (helper 0)])
      (set! result (remove-duplicates (flatten result) string=?))
      (sort result string<?)))
  (parse s))