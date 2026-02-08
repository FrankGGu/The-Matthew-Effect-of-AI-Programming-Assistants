(define (solve start end)
  (define (valid? start end)
    (define (remove-xs s)
      (list->string (filter (lambda (c) (not (equal? c #\X))) (string->list s))))

    (equal? (remove-xs start) (remove-xs end)))

  (define (check start end)
    (if (not (valid? start end))
        #f
        (let loop ([start-list (string->list start)]
                   [end-list (string->list end)])
          (cond
            [(and (empty? start-list) (empty? end-list)) #t]
            [(empty? start-list) #f]
            [(empty? end-list) #f]
            [else
             (let ([s (car start-list)]
                   [e (car end-list)])
               (cond
                 [(equal? s e) (loop (cdr start-list) (cdr end-list))]
                 [(equal? s #\L) (if (equal? e #\X)
                                      (loop (cdr start-list) end-list)
                                      #f)]
                 [(equal? s #\R) (if (equal? e #\X)
                                      #f
                                      (loop (cdr start-list) end-list))]
                 [(equal? s #\X) (if (equal? e #\L)
                                      #f
                                      (loop (cdr start-list) end-list))]
                 [else #f])))]))))

  (define (check-lr start end)
    (let loop ([start-list (string->list start)]
               [end-list (string->list end)]
               [si 0]
               [ei 0])
      (cond
        [(and (empty? start-list) (empty? end-list)) #t]
        [(empty? start-list) #t]
        [(empty? end-list) #t]
        [else
         (let ([s (car start-list)]
               [e (car end-list)])
           (cond
             [(equal? s #\X) (loop (cdr start-list) end-list (+ si 1) ei)]
             [(equal? e #\X) (loop start-list (cdr end-list) si (+ ei 1))]
             [(equal? s e) (cond
                             [(equal? s #\L) (if (>= si ei)
                                                   (loop (cdr start-list) (cdr end-list) 0 0)
                                                   #f)]
                             [(equal? s #\R) (if (<= si ei)
                                                   (loop (cdr start-list) (cdr end-list) 0 0)
                                                   #f)]
                             [else #f])]
             [else #f])))])))

  (and (valid? start end) (check-lr start end)))