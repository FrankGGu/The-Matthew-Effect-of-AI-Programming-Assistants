(define (rotated-digits n)
  (let loop ((i 1) (count 0))
    (cond
      ((> i n) count)
      (else
       (let ((s (number->string i)))
         (if (string-contains-rotated s)
             (loop (+ i 1) (+ count 1))
             (loop (+ i 1) count)))))))

(define (string-contains-rotated s)
  (and (string-contains-rotated-digits s)
       (not (string=? s (string-map (lambda (c)
                                        (cond ((char=? c #\2) #\5)
                                              ((char=? c #\5) #\2)
                                              ((char=? c #\6) #\9)
                                              ((char=? c #\9) #\6)
                                              (else c)))
                                      s)))))

(define (string-contains-rotated-digits s)
  (ormap (lambda (c) (memv c '(#\2 #\5 #\6 #\9))) (string->list s)))

(define (rotated-digits-helper n)
  (rotated-digits n))