(define (maxArea height)
  (let loop ((left 0) (right (sub1 (length height))) (max-area 0))
    (if (>= left right)
        max-area
        (let* ((width (- right left))
               (current-area (* width (min (list-ref height left) (list-ref height right)))))
          (loop (if (< (list-ref height left) (list-ref height right)) (add1 left) left)
                (if (< (list-ref height left) (list-ref height right)) right (sub1 right))
                (max max-area current-area))))))