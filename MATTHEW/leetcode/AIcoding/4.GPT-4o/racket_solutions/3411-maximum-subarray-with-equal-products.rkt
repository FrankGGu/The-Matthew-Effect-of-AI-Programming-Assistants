(define (maxEqualProducts nums)
  (define (product lst)
    (if (null? lst) 1
        (* (car lst) (product (cdr lst)))))
  (define (helper start end)
    (if (>= start end) 0
        (let ((current-product (product (sublist nums start end))))
          (max current-product (helper start (+ end 1)) (helper (+ start 1) end)))))
  (helper 0 1))

(maxEqualProducts '(1 2 3 4 5))