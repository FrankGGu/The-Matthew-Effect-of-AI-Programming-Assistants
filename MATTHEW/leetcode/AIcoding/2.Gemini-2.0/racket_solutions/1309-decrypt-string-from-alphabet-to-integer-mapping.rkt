(define (freq-alphabets s)
  (let loop ((i 0) (acc ""))
    (cond
      ((= i (string-length s)) acc)
      ((and (< (+ i 2) (string-length s)) (char=? #\# (string-ref s (+ i 2))))
       (let ((num (string->number (substring s i (+ i 2)))))
         (loop (+ i 3) (string-append acc (string (integer->char (+ (- num 1) (char->integer #\a)))))))
      (else
       (let ((num (string->number (substring s i (+ i 1)))))
         (loop (+ i 1) (string-append acc (string (integer->char (+ (- num 1) (char->integer #\a)))))))))))