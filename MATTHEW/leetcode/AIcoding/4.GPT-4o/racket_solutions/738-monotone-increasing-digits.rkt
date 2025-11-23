(define (monotoneIncreasingDigits n)
  (define (helper str idx)
    (if (<= idx 0)
        str
        (let* ((prev (string-ref str (- idx 1)))
               (curr (string-ref str idx)))
          (if (< prev curr)
              (begin
                (set! str (string-append (substring str 0 (- idx 1)) 
                                          (string (char->integer prev - 1))
                                          (make-string (- (string-length str) idx) #\9)))
                (helper str (- idx 1)))
              (helper str (- idx 1))))))
  (let ((str (number->string n)))
    (let ((result (helper str (- (string-length str) 1))))
      (string->number result))))

(monotoneIncreasingDigits 1234)