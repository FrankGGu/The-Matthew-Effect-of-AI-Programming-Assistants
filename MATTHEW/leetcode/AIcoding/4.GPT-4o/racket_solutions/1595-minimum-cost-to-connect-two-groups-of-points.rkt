(define (min-cost-connect-points points)
  (define (distance p1 p2)
    (+ (abs (- (car p1) (car p2)))
       (abs (- (cadr p1) (cadr p2)))))

  (define n (length points))
  (define edges '())

  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (when (< i j)
        (set! edges (cons (list (distance (list-ref points i) (list-ref points j)) i j) edges)))))

  (set! edges (sort edges (lambda (a b) (< (car a) (car b)))))

  (define groups (list (make-vector n #f) (make-vector n #f)))
  (define (find-group idx)
    (if (vector-ref (car groups) idx)
        (find-group (vector-ref (car groups) idx))
        idx))

  (define (union-groups idx1 idx2)
    (define root1 (find-group idx1))
    (define root2 (find-group idx2))
    (when (not (= root1 root2))
      (vector-set! (car groups) root1 root2)
      (set! (cadr groups) (+ (cadr groups) (car (memv (list root1 root2) edges))))))

  (define total-cost 0)
  (for ([edge edges])
    (define cost (car edge))
    (define idx1 (cadr edge))
    (define idx2 (caddr edge))
    (union-groups idx1 idx2)
    (set! total-cost (+ total-cost cost)))

  total-cost)

(min-cost-connect-points '((0 0) (2 2) (3 10) (5 2) (7 0)))