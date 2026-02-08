(define/contract (modified-graph-edges n edges source destination target)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer? (listof (listof exact-integer?)))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)]
          [w (third edge)])
      (vector-set! adj u (cons (list v w) (vector-ref adj u)))
      (vector-set! adj v (cons (list u w) (vector-ref adj v)))))

  (define dist (make-vector n +inf.0))
  (vector-set! dist source 0)
  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! heap (list 0 source))

  (define parent (make-vector n -1))

  (let loop ()
    (unless (heap-empty? heap)
      (let ([current (heap-remove! heap)])
        (let ([d (car current)]
              [u (cadr current)])
          (when (<= d (vector-ref dist u))
            (for ([neighbor (vector-ref adj u)])
              (let ([v (first neighbor)]
                    [w (second neighbor)])
                (let ([new-dist (+ d (if (= w -1) 1 w))])
                  (when (< new-dist (vector-ref dist v))
                    (vector-set! dist v new-dist)
                    (vector-set! parent v u)
                    (heap-add! heap (list new-dist v))))))))))
      (loop)))

  (when (> (vector-ref dist destination) target)
    (return '()))

  (define modified-edges '())
  (define (modify-edges u)
    (unless (= u source)
      (let ([v (vector-ref parent u)])
        (for ([edge edges])
          (when (or (and (= (first edge) u) (= (second edge) v))
                    (and (= (first edge) v) (= (second edge) u)))
            (when (= (third edge) -1)
              (let ([w (if (= u destination)
                           (- target (vector-ref dist v))
                           1)])
                (set! modified-edges (cons (list u v w) modified-edges))
                (set! modified-edges (cons (list v u w) modified-edges))))))
        (modify-edges v))))

  (modify-edges destination)

  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)]
          [w (third edge)])
      (unless (or (= w -1) (member edge modified-edges))
        (set! modified-edges (cons edge modified-edges)))))

  (remove-duplicates modified-edges))