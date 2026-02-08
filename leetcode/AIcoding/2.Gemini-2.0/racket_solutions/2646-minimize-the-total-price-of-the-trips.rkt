(define (minimum-total-price n edges prices trips)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define (dfs start end visited)
    (cond
      [(equal? start end) (list end)]
      [else
       (let loop ((neighbors (vector-ref adj start)))
         (cond
           [(null? neighbors) #f]
           [else
            (let ((neighbor (car neighbors)))
              (if (not (vector-ref visited neighbor))
                  (begin
                    (vector-set! visited neighbor #t)
                    (let ((path (dfs neighbor end visited)))
                      (if path (cons start path) (loop (cdr neighbors)))))
                  (loop (cdr neighbors))))))])]))

  (define (count-visits path)
    (define counts (make-vector n 0))
    (for-each (lambda (node)
                (vector-set! counts node (+ 1 (vector-ref counts node))))
              path)
    counts)

  (define visit-counts (make-vector n 0))
  (for-each (lambda (trip)
              (let ((visited (make-vector n #f)))
                (vector-set! visited (car trip) #t)
                (let ((path (dfs (car trip) (cadr trip) visited)))
                  (if path
                      (let ((counts (count-visits path)))
                        (for/list ((i (range n)))
                          (vector-set! visit-counts i (+ (vector-ref visit-counts i) (vector-ref counts i)))))))))
            trips)

  (define dp (make-vector n '(0 . 0))) ; (without_half . with_half)

  (define (calculate-dp node parent)
    (let ((without-half 0) (with-half (* (vector-ref prices node) (vector-ref visit-counts node) 1/2)))
      (for-each (lambda (neighbor)
                  (if (not (equal? neighbor parent))
                      (begin
                        (calculate-dp neighbor node)
                        (let ((child-dp (vector-ref dp neighbor)))
                          (set! without-half (+ without-half (min (car child-dp) (cdr child-dp))))
                          (set! with-half (+ with-half (car child-dp)))))))
                (vector-ref adj node))
      (vector-set! dp node (cons (+ (* (vector-ref prices node) (vector-ref visit-counts node)) without-half) with-half))))

  (calculate-dp 0 -1)
  (min (car (vector-ref dp 0)) (cdr (vector-ref dp 0))))