(define (eval-division equations values queries)
  (define graph (make-hash))
  (for ([i (in-range (length equations))])
    (define equation (list-ref equations i))
    (define a (list-ref equation 0))
    (define b (list-ref equation 1))
    (define v (list-ref values i))
    (hash-update! graph a (lambda (x) (if x (append x (list (list b v))) (list (list b v)))) '())
    (hash-update! graph b (lambda (x) (if x (append x (list (list a (/ 1.0 v)))) (list (list a (/ 1.0 v))))) '()))

  (define (dfs start end visited)
    (cond
      [(equal? start end) 1.0]
      [(hash-ref graph start #f)
       (let loop ([neighbors (hash-ref graph start #f)])
         (cond
           [(null? neighbors) -1.0]
           [else
            (let ([neighbor (car neighbors)]
                  [next-node (car neighbor)]
                  [weight (cadr neighbor)])
              (if (hash-ref visited next-node #f)
                  (loop (cdr neighbors))
                  (begin
                    (hash-set! visited next-node #t)
                    (let ([result (dfs next-node end visited)])
                      (if (= result -1.0)
                          (loop (cdr neighbors))
                          (* weight result)))))))]))]
      [else -1.0]))

  (map (lambda (query)
         (let ([a (list-ref query 0)]
               [b (list-ref query 1)])
           (let ([visited (make-hash)])
             (hash-set! visited a #t)
             (dfs a b visited))))
       queries))