(define (myAtoi str)
  (let loop ([i 0] [sign 1] [result 0] [started #f])
    (cond
      [(>= i (string-length str)) (* sign result)]
      [(and (not started) (char-whitespace? (string-ref str i)))
       (loop (add1 i) sign result started)]
      [(and (not started) (char=? (string-ref str i) #\+))
       (loop (add1 i) 1 result #t)]
      [(and (not started) (char=? (string-ref str i) #\-))
       (loop (add1 i) -1 result #t)]
      [(and (char-numeric? (string-ref str i)))
       (let* ([digit (- (char->integer (string-ref str i)) (char->integer #\0))]
              [new-result (+ (* result 10) digit)])
         (if (> new-result 2147483647)
             (if (= sign 1) 2147483647 -2147483648)
             (loop (add1 i) sign new-result #t)))]
      [else (* sign result)])))