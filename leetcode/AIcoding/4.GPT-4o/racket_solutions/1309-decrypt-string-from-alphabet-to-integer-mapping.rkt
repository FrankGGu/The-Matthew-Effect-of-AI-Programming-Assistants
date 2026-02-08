(define (freq-alphabet s)
  (define (decode-char c)
    (if (char=? c #\#)
        (begin
          (let ([num (substring s 0 2)])
            (set! s (substring s 2))
            (integer->char (+ (string->number num) 96))))
        (begin
          (set! s (substring s 1))
          (integer->char (+ (char->integer c) (- (char->integer #\a) 1))))))
  (define (helper str)
    (if (string-empty? str)
        ""
        (string-append (decode-char (string-ref str 0)) (helper (substring str 1)))))
  (helper s))