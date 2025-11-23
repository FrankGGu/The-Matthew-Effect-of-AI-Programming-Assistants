(define/contract (lucky-numbers matrix)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (define rows (length matrix))
  (define cols (if (null? matrix) 0 (length (car matrix))))
  (define row-mins
    (for/list ([row matrix])
      (apply min row)))
  (define col-maxs
    (for/list ([j (in-range cols)])
      (apply max (for/list ([i (in-range rows)]) (list-ref (list-ref matrix i) j)))))
  (filter (lambda (x) (member x col-maxs)) row-mins))