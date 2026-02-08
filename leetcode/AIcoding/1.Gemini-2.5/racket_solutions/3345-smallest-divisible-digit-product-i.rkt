(define (smallest-divisible-digit-product n)
  (cond
    ((= n 1) 1)
    ((= n 0) 0)
    (else
     (let ((digits '()))
       (for ((d (in-range 9 1 -1)))
         (when (> n 1)
           (for/while ((_ (in-naturals)))
             (when (zero? (modulo n d))
               (set! n (quotient n d))
               (set! digits (cons d digits))
               #t)
             #f)))

       (if (= n 1)
           (string->number (list->string (map (lambda (digit) (integer->char (+ (char->integer #\0) digit))) digits)))
           -1))))