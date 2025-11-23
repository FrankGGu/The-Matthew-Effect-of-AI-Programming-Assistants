(define (find-circle-end u parent)
  (if (= (vector-ref parent u) u)
      u
      (find-circle-end (vector-ref parent (vector-ref parent u)) parent)))

(define (union u v parent)
  (let ([root-u (find-circle-end u parent)]
        [root-v (find-circle-end v parent)])
    (if (not (= root-u root-v))
        (vector-set! parent root-v root-u)
        parent)))

(define (find-provinces matrix)
  (define n (length matrix))
  (define parent (list->vector (range n)))
  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (when (and (= (list-ref (list-ref matrix i) j) 1) (< i j))
        (union i j parent))))
  (define roots (set)
    (for ([i (in-range n)])
      (set-add! roots (find-circle-end i parent)))
    (set-count roots))

(find-provinces (read))