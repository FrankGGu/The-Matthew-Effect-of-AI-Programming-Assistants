(define (myAtoi s)
  (let loop ([i 0]
             [sign 1]
             [result 0]
             [started #f])
    (cond
      [(>= i (string-length s)) (* sign result)]
      [(and (not started) (char-whitespace? (string-ref s i)))
       (loop (add1 i) sign result started)]
      [(and (not started) (char=? (string-ref s i) #\+))
       (loop (add1 i) 1 result #t)]
      [(and (not started) (char=? (string-ref s i) #\-))
       (loop (add1 i) -1 result #t)]
      [(char-numeric? (string-ref s i))
       (let* ([digit (- (char->integer (string-ref s i)) (char->integer #\0))]
              [new-result (+ (* result 10) digit)])
         (if (> new-result 2147483647)
             (if (= sign 1) 2147483647 -2147483648)
             (loop (add1 i) sign new-result #t)))]
      [else (* sign result)])))