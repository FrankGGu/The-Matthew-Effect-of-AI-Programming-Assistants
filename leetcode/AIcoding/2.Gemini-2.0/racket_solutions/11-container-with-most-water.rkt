(define (max-area height)
  (let loop ([left 0] [right (- (length height) 1)] [max-area 0])
    (cond
      [(>= left right) max-area]
      [else
       (let* ([h (min (list (list-ref height left) (list-ref height right)))]
              [w (- right left)]
              [area (* h w)])
         (loop (if (< (list-ref height left) (list-ref height right)) (+ left 1) left)
               (if (>= (list-ref height left) (list-ref height right)) (- right 1) right)
               (max max-area area)))])))