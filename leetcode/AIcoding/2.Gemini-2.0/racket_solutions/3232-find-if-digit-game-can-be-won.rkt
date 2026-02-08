(define (digit-game s k)
  (define (solve s turn)
    (cond
      [(<= (string-length s) k)
       (if (equal? turn #t)
           #f
           #t)]
      [(equal? turn #t)
       (let loop ([i 0])
         (cond
           [(= i (- (string-length s) 1)) #f]
           [(let ([new-s (string-append (substring s 0 i) (substring s (+ i 2) (string-length s)))])
              (solve new-s #f)) #t]
           [else (loop (+ i 2))]
           ))]
      [else
       (let loop ([i 1])
         (cond
           [(= i (- (string-length s) 1)) #f]
           [(let ([new-s (string-append (substring s 0 i) (substring s (+ i 2) (string-length s)))])
              (solve new-s #t)) #t]
           [else (loop (+ i 2))]
           ))]))
  (solve s #t))