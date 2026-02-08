(define (maximum-number-robots costs running-costs budget)
  (define (solve l r)
    (if (> l r)
        0
        (let* ((sub-costs (list-ref costs l))
               (sub-running-costs (list-ref running-costs l))
               (max-cost (apply max (list-take costs (+ 1 (- r l)))))
               (sum-running-costs (apply + (list-take running-costs (+ 1 (- r l))))))
          (if (<= (+ max-cost (* sum-running-costs (- r l 1))) budget)
              (+ 1 (- r l))
              (solve l (- r 1))))))

  (define (max-robots costs running-costs budget)
    (let loop ([l 0] [r (- (length costs) 1)] [max-len 0])
      (cond
        [(> l r) max-len]
        [else
         (let* ((len (solve l r)))
           (if (> len max-len)
               (loop (+ l 1) r len)
               (loop (+ l 1) r max-len)))])))

  (cond
    [(null? costs) 0]
    [(null? running-costs) 0]
    [else (max-robots costs running-costs budget)]))