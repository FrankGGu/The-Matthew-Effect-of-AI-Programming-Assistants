(define (is-match s p)
  (define s-len (string-length s))
  (define p-len (string-length p))

  (define memo (make-hash))

  (define (dp i j)
    (cond
      [(hash-has-key? memo (cons i j)) (hash-ref memo (cons i j))]
      [(and (= i s-len) (= j p-len)) #t]
      [(= j p-len) #f]
      [(= i s-len)
       (if (and (> j p-len) (char=? (string-ref p j) #\*))
           (dp i (+ j 1))
           (and (not (zero? (- p-len j))) (string-for-each (lambda (c) (if (not (char=? c #\*)) (error "Invalid pattern")) ) (substring p j p-len)) #t)

           (and (not (zero? (- p-len j))) (string-for-each (lambda (c) (if (not (char=? c #\*)) (void) ) ) (substring p j p-len))  (andmap (lambda (c) (char=? c #\*)) (string->list (substring p j p-len))) )
           #f

          )]
      [(or (char=? (string-ref p j) #\?) (char=? (string-ref s i) (string-ref p j)))
       (begin
         (hash-set! memo (cons i j) (dp (+ i 1) (+ j 1)))
         (hash-ref memo (cons i j))))
      [(char=? (string-ref p j) #\*)
       (begin
         (hash-set! memo (cons i j) (or (dp i (+ j 1)) (dp (+ i 1) j)))
         (hash-ref memo (cons i j))))
      [else #f]))

  (dp 0 0))