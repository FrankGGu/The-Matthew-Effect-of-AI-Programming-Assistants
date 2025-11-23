(define (min-time-collect-apples n edges has-apple)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define (dfs u parent)
    (let loop ((neighbors (vector-ref adj u)) (total-time 0))
      (cond
        ((null? neighbors)
         (if (and (not (= u 0)) (or (vector-ref has-apple u) (> total-time 0)))
             2
             0))
        (else
         (let ((v (car neighbors)))
           (if (= v parent)
               (loop (cdr neighbors) total-time)
               (let ((child-time (dfs v u)))
                 (loop (cdr neighbors) (+ total-time child-time)))))))))

  (max 0 (- (dfs 0 -1) 2)))