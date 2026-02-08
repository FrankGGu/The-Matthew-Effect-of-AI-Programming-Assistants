(define (max-eaten-pizzas pizzas)
  (define (helper idx k)
    (if (or (zero? k) (>= idx (length pizzas)))
        0
        (max (helper (add1 idx) (sub1 k))
             (+ (list-ref pizzas idx) (helper (add1 idx) k)))))
  (helper 0 (length pizzas)))

(max-eaten-pizzas '(1 2 3 4 5))