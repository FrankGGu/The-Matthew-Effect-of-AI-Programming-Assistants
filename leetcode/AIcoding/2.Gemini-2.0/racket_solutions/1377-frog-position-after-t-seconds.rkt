(define (frog-position n edges t target)
  (define adj (make-vector (add1 n) '()))
  (for-each (lambda (e)
              (let ((u (car e)) (v (cadr e)))
                (begin
                  (set-vector! adj u (cons v (vector-ref adj u)))
                  (set-vector! adj v (cons u (vector-ref adj v))))))
            edges)
  (define visited (make-vector (add1 n) #f))
  (vector-set! visited 1 #t)
  (define (dfs node time prob)
    (cond
      [(and (= node target) (>= time 0))
       (if (= time 0)
           prob
           (let ((neighbors (filter (lambda (x) (not (vector-ref visited x))) (vector-ref adj node))))
             (if (null? neighbors)
                 prob
                 0.0)))]
      [(< time 0) 0.0]
      [else
       (let ((neighbors (filter (lambda (x) (not (vector-ref visited x))) (vector-ref adj node))))
         (if (null? neighbors)
             (if (= node target) prob 0.0)
             (let ((next-prob (/ prob (length neighbors))))
               (foldl (lambda (neighbor acc)
                        (begin
                          (vector-set! visited neighbor #t)
                          (let ((result (dfs neighbor (sub1 time) next-prob)))
                            (vector-set! visited neighbor #f)
                            (+ acc result))))
                      0.0
                      neighbors))))]))
  (dfs 1 t 1.0))