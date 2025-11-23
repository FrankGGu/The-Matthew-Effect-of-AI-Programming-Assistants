(define (rearrangeFruits fruits)
  (let* ((n (length fruits))
         (result (make-vector n)))
    (for ((i (in-range n)))
      (vector-set! result i (list-ref fruits (modulo i 2))))
    (vector->list result)))

(rearrangeFruits '(1 2 3 4 5))