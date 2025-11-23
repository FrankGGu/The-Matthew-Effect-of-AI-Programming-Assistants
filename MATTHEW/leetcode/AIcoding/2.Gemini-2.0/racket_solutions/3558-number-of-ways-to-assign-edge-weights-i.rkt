(define (min-number-of-ways edge-list n edges)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define (dfs start end visited path)
    (cond
      [(equal? start end) (reverse (cons start path))]
      [(member start visited) #f]
      [else
       (let ((neighbors (vector-ref adj start)))
         (let loop ((neighbors neighbors))
           (cond
             [(null? neighbors) #f]
             [else
              (let ((next (car neighbors)))
                (let ((result (dfs next end (cons start visited) (cons start path))))
                  (if result
                      result
                      (loop (cdr neighbors)))))])))]))

  (define path (dfs (car (car edges)) (cadr (car edges)) '() '()))

  (if (not path)
      0
      (let loop ((path (cdr path)) (prev (car path)) (xor 0))
        (if (null? path)
            (if (zero? xor) 1 0)
            (let ((curr (car path)))
              (let ((new-xor (bitwise-xor xor (hash (list prev curr))))
                    (new-path (cdr path)))
                (loop new-path curr new-xor)))))))