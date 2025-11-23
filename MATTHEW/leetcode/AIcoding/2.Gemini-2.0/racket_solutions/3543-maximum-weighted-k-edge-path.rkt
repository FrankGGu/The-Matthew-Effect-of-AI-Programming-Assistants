(define (maximum-weighted-k-edge-path n edges k)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge))
                    (w (caddr edge)))
                (vector-set! graph u (cons (list v w) (vector-ref graph u)))
                (vector-set! graph v (cons (list u w) (vector-ref graph v)))))
            edges)

  (define (dfs u visited remaining-edges current-weight)
    (if (= remaining-edges 0)
        current-weight
        (let loop ((neighbors (vector-ref graph u))
                   (max-weight -inf.0))
          (cond
            ((null? neighbors) max-weight)
            (else
             (let* ((neighbor (car neighbors))
                    (v (car neighbor))
                    (w (cadr neighbor)))
               (if (not (member v visited))
                   (let ((new-weight (dfs v (cons v visited) (- remaining-edges 1) (+ current-weight w))))
                     (loop (cdr neighbors) (max max-weight new-weight)))
                   (loop (cdr neighbors) max-weight))))))))

  (define (solve)
    (let loop ((start-node 0)
               (max-weight -inf.0))
      (cond
        ((= start-node n) max-weight)
        (else
         (let ((weight (dfs start-node (list start-node) k 0)))
           (loop (+ start-node 1) (max max-weight weight)))))))

  (solve))