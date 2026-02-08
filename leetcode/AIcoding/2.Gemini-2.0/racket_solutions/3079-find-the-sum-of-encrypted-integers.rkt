(define (decrypt s key)
  (let loop ([i 0] [res '()])
    (if (= i (string-length s))
        (list->string (reverse res))
        (let ([c (string-ref s i)])
          (cond
            [(char=? c #\_) (loop (+ i 1) (cons #\  res))]
            [(char=? c #\a) (loop (+ i 1) (cons #\1 res))]
            [(char=? c #\b) (loop (+ i 1) (cons #\2 res))]
            [(char=? c #\c) (loop (+ i 1) (cons #\3 res))]
            [(char=? c #\d) (loop (+ i 1) (cons #\4 res))]
            [(char=? c #\e) (loop (+ i 1) (cons #\5 res))]
            [(char=? c #\f) (loop (+ i 1) (cons #\6 res))]
            [(char=? c #\g) (loop (+ i 1) (cons #\7 res))]
            [(char=? c #\h) (loop (+ i 1) (cons #\8 res))]
            [(char=? c #\i) (loop (+ i 1) (cons #\9 res))]
            [else (loop (+ i 1) (cons c res))]))))))

(define (solve s key)
  (let ([decrypted-str (decrypt s key)])
    (if (string=? decrypted-str "")
        0
        (string->number decrypted-str))))

(define (sum-of-encrypted-integers strings key)
  (apply + (map (lambda (s) (solve s key)) strings)))