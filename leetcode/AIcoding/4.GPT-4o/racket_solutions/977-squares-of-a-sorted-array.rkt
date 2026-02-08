(define (sorted-squares nums)
  (let* ((n (length nums))
         (result (make-vector n 0))
         (left 0)
         (right (- n 1)))
    (let loop ()
      (if (< left (length nums))
          (begin
            (if (>= (abs (vector-ref nums left)) (abs (vector-ref nums right)))
                (begin
                  (vector-set! result right (sqr (vector-ref nums left)))
                  (set! left (+ left 1)))
                (begin
                  (vector-set! result right (sqr (vector-ref nums right)))
                  (set! right (- right 1))))
            (loop))))
    (vector->list result)))

(sorted-squares '(-4 -1 0 3 10))