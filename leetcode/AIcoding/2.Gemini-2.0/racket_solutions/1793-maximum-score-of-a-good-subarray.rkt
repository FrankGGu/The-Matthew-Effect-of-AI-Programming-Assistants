(define (maximum-score nums k)
  (let* ([n (length nums)]
         [left k]
         [right k]
         [min-val (list-ref nums k)]
         [max-score min-val])
    (while (and (> left 0) (< right (- n 1)))
      (if (> (list-ref nums (- left 1)) (list-ref nums (+ right 1)))
          (begin
            (set! left (- left 1))
            (set! min-val (min min-val (list-ref nums left))))
          (begin
            (set! right (+ right 1))
            (set! min-val (min min-val (list-ref nums right)))))
      (set! max-score (max max-score (* min-val (+ (- right left) 1)))))
    (while (> left 0)
      (set! left (- left 1))
      (set! min-val (min min-val (list-ref nums left)))
      (set! max-score (max max-score (* min-val (+ (- right left) 1)))))
    (while (< right (- n 1))
      (set! right (+ right 1))
      (set! min-val (min min-val (list-ref nums right)))
      (set! max-score (max max-score (* min-val (+ (- right left) 1)))))
    max-score))