(define (path-exists? n edges queries)
  (define adj (make-vector (add1 n) '()))
  (for-each (lambda (edge)
              (vector-set! adj (car edge) (cons (cadr edge) (vector-ref adj (car edge)))))
            edges)
  (define (bfs start end)
    (let ([visited (make-vector (add1 n) #f)]
          [queue (list start)])
      (vector-set! visited start #t)
      (letrec ([loop (lambda ()
                        (cond
                          [(null? queue) #f]
                          [else
                           (let ([curr (car queue)])
                             (if (= curr end)
                                 #t
                                 (begin
                                   (for-each (lambda (neighbor)
                                               (if (not (vector-ref visited neighbor))
                                                   (begin
                                                     (vector-set! visited neighbor #t)
                                                     (set! queue (append queue (list neighbor))))))
                                             (vector-ref adj curr))
                                   (set! queue (cdr queue))
                                   (loop)))))]))
        (loop))))
  (map (lambda (query) (bfs (car query) (cadr query))) queries))