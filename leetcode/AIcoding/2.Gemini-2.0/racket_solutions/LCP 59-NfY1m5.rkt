(define (cross-bridge speeds)
  (define (solve speeds acc)
    (cond
      [(empty? speeds) acc]
      [(empty? (cdr speeds)) (+ acc (car speeds))]
      [(empty? (cddr speeds)) (+ acc (max (car speeds) (cadr speeds)))]
      [else
       (let* ([a (car speeds)]
              [b (cadr speeds)]
              [y (car (reverse speeds))]
              [x (cadr (reverse speeds))])
         (if (+ b b (+ a x y))
             (solve (cdr speeds) (+ acc (+ y a x y)))
             (solve (cdr speeds) (+ acc (+ b a x b)))))]))
  (solve (sort speeds <) 0))