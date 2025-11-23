(define (k-nearest-obstacles queries grid)
  (define rows (length grid))
  (define cols (length (first grid)))
  (define obstacles (for/list ([i (in-range rows)]
                               [j (in-range cols)]
                               #:when (eq? (list-ref (list-ref grid i) j) 1)]
                          (list i j)))

  (define (distance a b)
    (+ (abs (- (first a) (first b))) (abs (- (second a) (second b)))))

  (define (nearest k q)
    (let* ([distances (map (lambda (obs) (distance obs q)) obstacles)]
           [sorted (sort distances <)]
           [filtered (filter (lambda (d) (<= d (car sorted))) sorted)])
      (if (>= (length filtered) k)
          (car (sort (take (sort filtered <) k) >))
          -1)))

  (map (lambda (q) (nearest (second q) (first q))) queries))