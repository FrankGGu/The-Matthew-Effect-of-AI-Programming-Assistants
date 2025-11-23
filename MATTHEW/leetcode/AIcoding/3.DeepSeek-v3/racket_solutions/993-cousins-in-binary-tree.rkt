(define/contract (is-cousins root x y)
  (-> (or/c null? (list/c exact-integer? (or/c null? (list/c any/c)) (list/c exact-integer? (or/c null? (list/c any/c)))) boolean?)

  (define (find-parent-and-depth root target parent depth)
    (cond
      [(null? root) (values #f 0)]
      [(= (car root) target) (values parent depth)]
      [else
       (let-values ([(p1 d1) (find-parent-and-depth (cadr root) target (car root) (+ depth 1))])
       (if (and p1 d1)
           (values p1 d1)
           (find-parent-and-depth (caddr root) target (car root) (+ depth 1)))]))

  (let-values ([(px dx) (find-parent-and-depth root x #f 0)]
               [(py dy) (find-parent-and-depth root y #f 0)])
    (and (not (eq? px py)) (= dx dy))))