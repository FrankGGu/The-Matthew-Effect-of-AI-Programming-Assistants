(define (can-partition nums)
  (define total (apply + nums))
  (if (odd? total) 
      #f 
      (let* ((target (/ total 2))
             (n (length nums))
             (dp (make-vector (+ target 1) #f)))
        (vector-set! dp 0 #t)
        (for ([num nums])
          (for ([j (range target -1 -1)])
            (when (and (vector-ref dp j) (<= (+ j num) target))
              (vector-set! dp (+ j num) #t))))
        (vector-ref dp target))))

(display (can-partition '(1 5 11 5))) ; Output: #t