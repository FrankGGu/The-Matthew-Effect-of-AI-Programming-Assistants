(define/contract (max-area height)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right (sub1 (length height))] [max-area 0])
    (if (>= left right)
        max-area
        (let* ([h (min (list-ref height left) (list-ref height right))]
               [w (- right left)]
               [area (* h w)])
          (if (> area max-area)
              (loop (add1 left) right area)
              (loop left (sub1 right) max-area))))))