(define (get-power n)
  (define (helper x count)
    (if (= x 1)
        count
        (helper (if (even? x) (/ x 2) (+ (* x 3) 1)) (+ count 1))))
  (helper n 0))

(define (get-kth lo hi k)
  (define power-values
    (map (lambda (x) (list x (get-power x))) (range lo (+ hi 1))))
  (define sorted (sort power-values (lambda (a b) (or (< (second a) (second b)) 
                                                       (and (= (second a) (second b)) 
                                                            (< (first a) (first b)))))))
  (first (list-ref sorted (- k 1))))

(get-kth lo hi k)