(define (kth-nearest-obstacle queries grid k)
  (define m (length grid))
  (define n (length (car grid)))

  (define obstacles
    (for/list ([i (in-range m)]
               [j (in-range n)]
               #:when (= (list-ref (list-ref grid i) j) 1))
      (list i j)))

  (define (distance p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))

  (for/list ([query queries])
    (define row (car query))
    (define col (cadr query))

    (define distances
      (map (lambda (obstacle) (list (distance (list row col) obstacle) obstacle)) obstacles))

    (define sorted-obstacles
      (sort distances < #:key car))

    (if (<= k (length sorted-obstacles))
        (let ([kth-obstacle (list-ref (list-ref sorted-obstacles (sub1 k)) 1)])
          (+ (* 100 (car kth-obstacle)) (cadr kth-obstacle)))
        -1)))