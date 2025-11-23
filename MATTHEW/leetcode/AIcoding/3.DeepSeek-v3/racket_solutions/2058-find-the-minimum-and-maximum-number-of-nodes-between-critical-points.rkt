(define/contract (nodes-between-critical-points head)
  (-> (or/c list? null?) (listof exact-integer?))
  (define (get-values lst)
    (let loop ([prev #f] [curr lst] [index 0] [crit-points '()])
      (cond
        [(null? curr) crit-points]
        [(null? (cdr curr)) crit-points]
        [(null? (cddr curr)) crit-points]
        [else
         (let ([x (car curr)]
               [y (cadr curr)]
               [z (caddr curr)])
           (if (or (and (> x y) (< y z))
               (and (< x y) (> y z)))
               (loop (cons index prev) (cdr curr) (+ index 1) (cons index crit-points))
               (loop prev (cdr curr) (+ index 1) crit-points)))])))
  (let ([crit-points (reverse (get-values head))])
    (if (< (length crit-points) 2)
        '(-1 -1)
        (let ([min-dist (apply min (map (lambda (x y) (- y x)) (crit-points (cdr crit-points)))])
          (list min-dist (- (last crit-points) (first crit-points))))))