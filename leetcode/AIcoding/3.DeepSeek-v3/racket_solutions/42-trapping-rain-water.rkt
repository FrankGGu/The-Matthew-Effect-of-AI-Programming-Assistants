(define/contract (trap height)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? height) 0
      (let loop ([left 0]
                 [right (sub1 (length height))]
                 [left-max 0]
                 [right-max 0]
                 [result 0])
        (if (> left right)
            result
            (if (< (list-ref height left) (list-ref height right))
                (if (>= (list-ref height left) left-max)
                    (loop (add1 left) right (list-ref height left) right-max result)
                    (loop (add1 left) right left-max right-max (+ result (- left-max (list-ref height left)))))
                (if (>= (list-ref height right) right-max)
                    (loop left (sub1 right) left-max (list-ref height right) result)
                    (loop left (sub1 right) left-max right-max (+ result (- right-max (list-ref height right)))))))))