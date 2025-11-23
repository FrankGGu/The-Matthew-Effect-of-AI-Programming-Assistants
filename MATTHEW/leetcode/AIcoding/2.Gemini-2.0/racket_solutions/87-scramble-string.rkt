(define (is-scramble s1 s2)
  (define (string->char-list s)
    (string->list s))

  (define (char-list->string lst)
    (list->string lst))

  (define (solve s1 s2)
    (cond
      [(not (= (string-length s1) (string-length s2))) #f]
      [(string=? s1 s2) #t]
      [(string-length s1) (let ([sorted-s1 (sort (string->char-list s1) char<?)]
                                 [sorted-s2 (sort (string->char-list s2) char<?)])
                             (if (not (equal? sorted-s1 sorted-s2))
                                 #f
                                 (let loop ([i 1])
                                   (cond
                                     [(= i (string-length s1)) #f]
                                     [(and (solve (substring s1 0 i) (substring s2 0 i))
                                           (solve (substring s1 i (string-length s1)) (substring s2 i (string-length s2)))) #t]
                                     [(and (solve (substring s1 0 i) (substring s2 (- (string-length s2) i) (string-length s2)))
                                           (solve (substring s1 i (string-length s1)) (substring s2 0 (- (string-length s2) i)))) #t]
                                     [else (loop (+ i 1))])))))]
      [else #f]))

  (solve s1 s2))