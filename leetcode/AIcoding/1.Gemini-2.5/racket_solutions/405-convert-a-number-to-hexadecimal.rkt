(define (digit->hex-char d)
  (cond
    ((< d 10) (integer->char (+ (char->integer #\0) d)))
    (else (integer->char (+ (char->integer #\a) (- d 10))))))

(define (to-hex num)
  (cond
    ((zero? num) "0")
    (else
     (let loop ((n (bitwise-and num #xffffffff))
                (result '()))
       (if (zero? n)
           (string-reverse (list->string result))
           (loop (quotient n 16)
                 (cons (digit->hex-char (remainder n 16)) result)))))))