(define (most-profitable-path-in-a-tree n edges amount)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define (bfs start)
    (define dist (make-vector n #f))
    (define parent (make-vector n #f))
    (vector-set! dist start 0)
    (vector-set! parent start -1)
    (define q (list start))
    (let loop ()
      (if (empty? q)
          (values dist parent)
          (let* ((u (car q))
                 (neighbors (vector-ref graph u)))
            (for-each (lambda (v)
                        (if (not (vector-ref dist v))
                            (begin
                              (vector-set! dist v (+ 1 (vector-ref dist u)))
                              (vector-set! parent v u)
                              (set! q (append q (list v))))))
                      neighbors)
            (set! q (cdr q))
            (loop)))))

  (define (get-path-to-root target parent)
    (let loop ((curr target) (path '()))
      (if (= curr -1)
          path
          (loop (vector-ref parent curr) (cons curr path)))))

  (define (calculate-profit start amount path)
    (let ((half-len (quotient (length path) 2)))
      (let loop ((i 0) (profit 0) (remaining-path path))
        (cond
          ((empty? remaining-path) profit)
          (else
           (let ((node (car remaining-path)))
             (cond
               ((< i half-len) (loop (+ i 1) (+ profit (vector-ref amount node)) (cdr remaining-path)))
               ((= i half-len) (loop (+ i 1) (+ profit (/ (vector-ref amount node) 2)) (cdr remaining-path)))
               (else (loop (+ i 1) (+ profit (vector-ref amount node)) (cdr remaining-path))))))))))

  (define (dfs u parent profit)
    (define is-leaf? (= (length (vector-ref graph u)) 1))
    (if is-leaf?
        profit
        (let ((max-profit #f))
          (for-each (lambda (v)
                      (if (not (= v parent))
                          (let ((new-profit (dfs v u profit)))
                            (if (or (not max-profit) (> new-profit max-profit))
                                (set! max-profit new-profit)))))
                    (vector-ref graph u))
          max-profit)))

  (let-values (((dist parent) (bfs 0)))
    (let ((path (get-path-to-root (- n 1) parent)))
      (let ((initial-profit (calculate-profit 0 amount path)))
        (dfs 0 -1 (vector-ref amount 0))))))