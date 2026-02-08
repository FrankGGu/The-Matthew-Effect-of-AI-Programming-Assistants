(define (remove-boxes boxes)
  (define (calculate-score boxes memo)
    (cond
      [(hash-has-key? memo boxes) (hash-ref memo boxes)]
      [(null? boxes) 0]
      [else
       (let* ([first-color (car (car boxes))]
              [first-len (car (cdr (car boxes)))]
              [i (let loop ([i 1] [rest (cdr boxes)])
                   (cond
                     [(null? rest) (length boxes)]
                     [(equal? first-color (car (car rest))) i]
                     [else (loop (+ i 1) (cdr rest))]))])
         (let ([removed-first-score (* first-len first-len)]
               [without-first-score (+ removed-first-score (calculate-score (drop boxes 1) memo))])

           (let loop ([j 1] [rest (cdr boxes)] [max-score without-first-score])
             (cond
               [(null? rest)
                (hash-set! memo boxes max-score)
                max-score]
               [(equal? first-color (car (car rest)))
                (let* ([new-boxes (append (take boxes j) (drop boxes (+ j 1)))]
                       [current-score (+ (* (+ first-len (car (cdr (car rest)))) (+ first-len (car (cdr (car rest)))))
                                          (calculate-score new-boxes memo))])
                  (loop (+ j 1) (cdr rest) (max max-score current-score)))
               ]
               [else (loop (+ j 1) (cdr rest) max-score)]))
           )
         )]))

  (define (compress-boxes boxes)
    (let loop ([acc '()] [curr-color #f] [curr-count 0] [rest boxes])
      (cond
        [(null? rest)
         (if (not (equal? curr-color #f))
             (reverse (cons (list curr-color curr-count) acc))
             (reverse acc))]
        [(equal? curr-color (car rest))
         (loop acc curr-color (+ curr-count 1) (cdr rest))]
        [else
         (if (not (equal? curr-color #f))
             (loop (cons (list curr-color curr-count) acc) (car rest) 1 (cdr rest))
             (loop acc (car rest) 1 (cdr rest)))])))

  (calculate-score (compress-boxes boxes) (make-hash)))