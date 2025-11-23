(define (maxStrength nums k)
  (define (max-product subarrays)
    (if (null? subarrays) 1
        (* (car subarrays) (max-product (cdr subarrays)))))

  (define (disjoint-subarrays nums k)
    (if (or (= k 0) (null? nums)) 
        (list '())
        (append 
          (map (lambda (x) (cons (car nums) x)) 
               (disjoint-subarrays (cdr nums) (- k 1)))
          (disjoint-subarrays (cdr nums) k))))

  (define subarrays (disjoint-subarrays nums k))
  (define products (map max-product subarrays))
  (apply max products))

(maxStrength '(3 -1 -5 2 5 -9) 2)