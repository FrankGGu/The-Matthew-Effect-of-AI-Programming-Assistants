#lang racket

(define (count-digits num)
  (let ((counts (make-vector 10 0)))
    (if (zero? num)
        (begin (vector-set! counts 0 1) (vector->list counts))
        (let loop ((n num))
          (unless (zero? n)
            (let ((digit (remainder n 10)))
              (vector-set! counts digit (+ (vector-ref counts digit) 1))
              (loop (quotient n 10))))
          (vector->list counts)))))

(define (reordered-power-of-2? n)
  (let ((n-counts (count-digits n)))
    (let loop ((power-of-2 1))
      (cond
        ((> power-of-2 1073741824)
         #f)
        ((equal? n-counts (count-digits power-of-2))
         #t)
        (else
         (loop (* power-of-2 2)))))))