(define (convert-to-base7 num)
  (cond
    ((zero? num) "0")
    ((negative? num) (string-append "-" (convert-to-base7 (- num))))
    (else
     (let loop ((n num) (acc '()))
       (if (zero? n)
           (list->string (map (lambda (d) (integer->char (+ (char->integer #\0) d))) (reverse acc)))
           (loop (quotient n 7) (cons (modulo n 7) acc)))))))