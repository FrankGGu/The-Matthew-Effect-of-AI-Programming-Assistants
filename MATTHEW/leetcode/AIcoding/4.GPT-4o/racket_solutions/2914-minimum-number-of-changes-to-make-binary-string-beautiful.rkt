(define (min-changes s)
  (define n (string-length s))
  (define changes 0)
  (define (next-char c)
    (if (equal? c #\0) #\1 #\0))
  (define (helper i prev)
    (if (>= i n)
        changes
        (let* ((c (string-ref s i))
               (expected (next-char prev)))
          (if (equal? c expected)
              (helper (+ i 1) c)
              (begin
                (set! changes (+ changes 1))
                (helper (+ i 1) c))))))
  (helper 0 #\0))

(min-changes "0100")