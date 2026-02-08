(define (smallest-good-base n)
  (define (good-base k)
    (let loop ((l 2) (r n))
      (if (> l r) #f
          (let ((m (floor (+ l r) 2)))
            (let ((sum 1) (power 1))
              (for ((i (in-range 1 k)))
                (set! power (* power m))
                (if (> (+ sum power) n) (set! sum (+ n 1)))
                (set! sum (+ sum power)))
              (cond
                ((= sum n) m)
                ((> sum n) (loop l (- m 1)))
                (else (loop (+ m 1) r))))))))

  (let loop ((k (floor (+ (log n) (log (/ 2 (log n)))) (log 2))))
    (cond
      ((<= k 1) (number->string (- n 1)))
      ((good-base k) => (lambda (base) (number->string base)))
      (else (loop (- k 1))))))