(define (training-plan tasks dependencies)
  (let* ((n (length tasks))
         (indegrees (make-vector n 0))
         (graph (make-vector n '()))
         (result '()))
    (for ([dep dependencies])
      (let ([from (car dep)]
            [to (cadr dep)])
        (vector-set! graph from (cons to (vector-ref graph from)))
        (vector-set! indegrees to (+ 1 (vector-ref indegrees to)))))
    (let loop ([queue (list)])
      (if (= (length result) n)
          (reverse result)
          (let* ([new-queue (list)]
                 [_ (for/list ([i (range n)])
                     (when (and (not (member i result)) (= (vector-ref indegrees i) 0))
                       (set! queue (cons i queue))))
                 ]
            (cond
              [(null? queue) (if (= (length result) n) (reverse result) '())]
              [else
               (let ([node (car queue)])
                 (set! result (cons node result))
                 (for ([neighbor (vector-ref graph node)])
                   (vector-set! indegrees neighbor (- (vector-ref indegrees neighbor) 1)))
                 (loop (cdr queue)))]))))))