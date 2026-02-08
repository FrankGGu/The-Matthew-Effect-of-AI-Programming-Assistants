(define (closest-dessert-cost base costs target)
  (define (helper current-cost index)
    (if (= index (length costs))
        (if (>= current-cost target) 
            current-cost 
            (if (>= (add1 current-cost) target) 
                (add1 current-cost) 
                current-cost))
        (let ((with-cost (+ current-cost (list-ref costs index)))
              (without-cost current-cost))
          (let ((with-next (helper with-cost (add1 index)))
                (without-next (helper without-cost (add1 index))))
            (if (or (and (<= with-next target) (>= without-next target))
                    (< (abs (- with-next target)) (abs (- without-next target))))
                with-next
                without-next)))))

  (let loop ((i 0) (best-cost 0))
    (if (< i (length costs))
        (let ((cost (helper base i)))
          (loop (add1 i) (if (< (abs (- cost target)) (abs (- best-cost target)))
                            cost
                            best-cost)))
        best-cost)))

(define (closest-dessert-cost main)
  (closest-dessert-cost (first main) (second main) (third main)))