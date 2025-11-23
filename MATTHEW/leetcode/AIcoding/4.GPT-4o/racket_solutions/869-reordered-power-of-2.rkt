(define (reorderedPowerOf2 n)
  (define (digits n)
    (sort (string->list (number->string n)) char<?))
  (define (is-power-of-2 n)
    (let loop ((x 1))
      (if (= x n) #t
          (if (> x n) #f (loop (* x 2))))))
  (define sorted-digits (digits n))
  (for/or ([i (in-range 30)]) 
    (let ((power-of-2 (expt 2 i)))
      (equal? sorted-digits (digits power-of-2)))))

(reorderedPowerOf2)