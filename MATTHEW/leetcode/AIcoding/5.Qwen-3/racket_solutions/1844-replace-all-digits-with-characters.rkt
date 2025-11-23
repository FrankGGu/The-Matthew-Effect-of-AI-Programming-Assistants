(define (replace-all-digits-with-characters s)
  (define (char->int c)
    (- (char->integer c) 48))
  (define (f i)
    (if (>= i (string-length s))
        ""
        (string-append
         (string (integer->char (+ (char->integer (string-ref s i)) (char->int (string-ref s (+ i 1))))))
         (f (+ i 2)))))
  (f 0))