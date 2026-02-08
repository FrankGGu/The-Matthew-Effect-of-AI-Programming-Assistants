(define/contract (modified-matrix matrix)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [max-cols (for/list ([j (in-range cols)])
                     (apply max (for/list ([i (in-range rows)]) (list-ref (list-ref matrix i) j))))])
    (for/list ([row matrix])
      (for/list ([elem row] [max-col max-cols])
        (if (= elem -1) max-col elem)))))