(define (max-value n x)
  (let* ((n-len (string-length n))
         (is-negative? (char=? (string-ref n 0) #\-))
         (x-char (integer->char (+ (char->integer #\0) x)))
         (start-idx (if is-negative? 1 0)))

    (let loop ((i start-idx))
      (cond
        ((= i n-len)
         (string-append n (string x-char)))
        (is-negative?
         (let ((current-digit-char (string-ref n i)))
           (if (char<? x-char current-digit-char)
               (string-append (substring n 0 i) (string x-char) (substring n i))
               (loop (+ i 1)))))
        (else
         (let ((current-digit-char (string-ref n i)))
           (if (char>? x-char current-digit-char)
               (string-append (substring n 0 i) (string x-char) (substring n i))
               (loop (+ i 1)))))))))