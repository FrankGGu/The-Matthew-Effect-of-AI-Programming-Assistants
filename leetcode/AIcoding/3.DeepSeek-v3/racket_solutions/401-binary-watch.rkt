(define (read-binary-watch turnedOn)
  (define (count-bits n)
    (if (zero? n) 0 (+ (modulo n 2) (count-bits (arithmetic-shift n -1)))))
  (filter
   (lambda (s) (not (null? s)))
   (for*/list ([h (in-range 12)]
               [m (in-range 60)]
               #:when (= (+ (count-bits h) (count-bits m)) turnedOn))
     (format "~a:~a" h (if (< m 10) (format "0~a" m) m)))))