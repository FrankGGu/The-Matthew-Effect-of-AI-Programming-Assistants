(define (min-cost-cutting-cake cost)
  (let* ((n (length cost))
         (total-cost (apply + cost)))
    (if (zero? n) 
        0
        (let loop ((i 0) (j 0) (min-cost total-cost))
          (if (>= i n)
              min-cost
              (let ((cut-cost (+ (list-ref cost i) (if (zero? i) 0 (list-ref cost (- i 1))))))
                (loop (+ i 1) j (min min-cost cut-cost))))))))

(min-cost-cutting-cake '(1 2 3 4 5))