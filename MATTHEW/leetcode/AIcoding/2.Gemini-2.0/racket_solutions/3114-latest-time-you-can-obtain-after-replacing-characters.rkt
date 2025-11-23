(define (maximum-time s)
  (define (char->int c)
    (cond [(char=? c #\?) -1]
          [else (- (char->integer c) (char->integer #\0))]))

  (define (int->char i)
    (if (= i -1) #\? (integer->char (+ i (char->integer #\0)))))

  (define (can-be-first-digit d)
    (or (= d -1) (<= d 2)))

  (define (can-be-second-digit first-digit d)
    (cond [(= first-digit 2) (or (= d -1) (<= d 3))]
          [else (or (= d -1) (<= d 9))]))

  (define (can-be-third-digit d)
    (or (= d -1) (<= d 5)))

  (define (can-be-fourth-digit d)
    (or (= d -1) (<= d 9)))

  (define (solve s)
    (let* ([chars (string->list s)]
           [first-digit (char->int (list-ref chars 0))]
           [second-digit (char->int (list-ref chars 1))]
           [third-digit (char->int (list-ref chars 3))]
           [fourth-digit (char->int (list-ref chars 4))]
           [new-first-digit (if (= first-digit -1)
                                  (if (can-be-second-digit 2 second-digit) 2 1)
                                  first-digit)]
           [new-second-digit (if (= second-digit -1)
                                   (if (= new-first-digit 2) 3 9)
                                   second-digit)]
           [new-third-digit (if (= third-digit -1) 5 third-digit)]
           [new-fourth-digit (if (= fourth-digit -1) 9 fourth-digit)])
      (string-append (string (int->char new-first-digit))
                     (string (int->char new-second-digit))
                     ":"
                     (string (int->char new-third-digit))
                     (string (int->char new-fourth-digit)))))

  (solve s))