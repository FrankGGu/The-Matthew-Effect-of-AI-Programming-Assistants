(define (minimizeTotalPrice n edges price trips)
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! graph u (cons v (vector-ref graph u)))
                (vector-set! graph v (cons u (vector-ref graph v)))))
            edges)

  (define (dfs node visited trips remaining-price)
    (if (zero? remaining-price)
        (if (not (null? trips))
            (minimizeTotalPrice n edges price (cdr trips))
            0)
        (let loop ((total-price (if (memv node visited) 
                                    0 
                                    (+ (vector-ref price node) (if (null? trips) 0 (dfs (car trips) (cons node visited) (cdr trips) remaining-price))))))
                   (next-edges (vector-ref graph node)))
          (if (null? next-edges)
              total-price
              (loop (+ total-price (dfs (car next-edges) (cons node visited) trips remaining-price)) (cdr next-edges))))))

  (dfs 0 '() trips 0))

(define (minimizeTotalPriceWrapper n edges price trips)
  (minimizeTotalPrice n edges price trips))