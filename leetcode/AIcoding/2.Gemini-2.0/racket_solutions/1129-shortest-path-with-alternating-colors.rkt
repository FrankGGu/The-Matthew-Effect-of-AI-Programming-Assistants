(define (shortest-alternating-paths n red-edges blue-edges)
  (define graph (make-vector n (list '() '()))) ; 0: red, 1: blue
  (for ([edge red-edges])
    (vector-set! graph (car edge) (cons (cons (cdr edge) 0) (vector-ref graph (car edge) 0)))))
  (for ([edge blue-edges])
    (vector-set! graph (car edge) (cons (cons (cdr edge) 1) (vector-ref graph (car edge) 1)))))

  (define dist (make-vector n (list #f #f))) ; 0: red, 1: blue
  (vector-set! dist 0 (list 0 0))

  (define q (make-queue))
  (enqueue! q (cons 0 0)) ; (node, color)
  (enqueue! q (cons 0 1))

  (define (bfs)
    (let loop ()
      (if (queue-empty? q)
          #t
          (let* ([curr (dequeue! q)]
                 [node (car curr)]
                 [color (cdr curr)]
                 [edges (vector-ref graph node)]
                 [next-color (if (= color 0) 1 0)])
            (for ([edge (list-ref edges next-color)])
              (let ([neighbor (car edge)])
                (if (not (list-ref (vector-ref dist neighbor) next-color))
                    (begin
                      (vector-set! dist neighbor (list-set (vector-ref dist neighbor) next-color (+ (list-ref (vector-ref dist node) color) 1)))
                      (enqueue! q (cons neighbor next-color))))))
            (loop)))))

  (bfs)

  (define result (make-vector n -1))
  (for ([i (in-range n)])
    (cond
      [(and (list-ref (vector-ref dist i) 0) (list-ref (vector-ref dist i) 1))
       (vector-set! result i (min (list-ref (vector-ref dist i) 0) (list-ref (vector-ref dist i) 1)))]
      [(list-ref (vector-ref dist i) 0)
       (vector-set! result i (list-ref (vector-ref dist i) 0))]
      [(list-ref (vector-ref dist i) 1)
       (vector-set! result i (list-ref (vector-ref dist i) 1))]))

  (vector->list result))