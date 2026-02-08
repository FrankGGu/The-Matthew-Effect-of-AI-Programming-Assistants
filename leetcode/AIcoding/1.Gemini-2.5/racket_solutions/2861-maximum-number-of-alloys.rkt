#lang racket

(define (maximum-number-of-alloys n k budget composition stock costs)

  (define (can-build? num-alloys)
    (if (= num-alloys 0)
        #t ; Can always build 0 alloys
        (let ((min-total-cost
               (for/fold ((current-min-cost +inf.0)) ((j (in-range k))) ; Iterate through each factory
                 (let* ((current-factory-composition (list-ref composition j))
                        (factory-cost
                         (for/fold ((current-metal-cost 0)) ((i (in-range n))) ; Iterate through each metal type
                           (let* ((required-metal (* (list-ref current-factory-composition i) num-alloys))
                                  (available-stock (list-ref stock i))
                                  (metal-price (list-ref costs i)))
                             (+ current-metal-cost
                                (if (> required-metal available-stock)
                                    (* (- required-metal available-stock) metal-price)
                                    0))))))
                   (min current-min-cost factory-cost))))))
          (<= min-total-cost budget))))

  (let loop ((low 0) (high 2000000000) (ans 0))
    (if (> low high)
        ans
        (let* ((mid (exact-floor (/ (+ low high) 2))))
          (if (can-build? mid)
              (loop (+ mid 1) high mid)
              (loop low (- mid 1) ans))))))