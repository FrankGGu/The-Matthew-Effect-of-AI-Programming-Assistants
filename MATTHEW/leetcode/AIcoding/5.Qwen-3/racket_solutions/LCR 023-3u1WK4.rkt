(define (get-intersection-node head-a head-b)
  (define (get-length node)
    (if (not node)
        0
        (+ 1 (get-length (cdr node)))))
  (define len-a (get-length head-a))
  (define len-b (get-length head-b))
  (define (advance node steps)
    (if (<= steps 0)
        node
        (advance (cdr node) (- steps 1))))
  (define a (if (> len-a len-b) (advance head-a (- len-a len-b)) head-a))
  (define b (if (> len-b len-a) (advance head-b (- len-b len-a)) head-b))
  (let loop ()
    (if (or (not a) (not b))
        #f
        (if (eqv? a b)
            a
            (loop (cdr a) (cdr b))))))