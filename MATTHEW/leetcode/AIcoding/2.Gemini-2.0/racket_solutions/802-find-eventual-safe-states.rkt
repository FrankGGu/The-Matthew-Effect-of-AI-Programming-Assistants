(define (eventual-safe-nodes graph)
  (let* ((n (length graph))
         (safe? (make-vector n #f))
         (visited? (make-vector n #f))
         (in-stack? (make-vector n #f))
         (dfs (lambda (node)
                (if (vector-ref in-stack? node)
                    #f
                    (if (vector-ref visited? node)
                        (vector-ref safe? node)
                        (begin
                          (vector-set! visited? node #t)
                          (vector-set! in-stack? node #t)
                          (let loop ((neighbors (vector-ref graph node)))
                            (cond
                              ((null? neighbors) #t)
                              (else
                                (if (not (dfs (car neighbors)))
                                    (begin
                                      (vector-set! in-stack? node #f)
                                      #f)
                                    (loop (cdr neighbors))))))
                          (vector-set! in-stack? node #f)
                          (vector-set! safe? node #t)
                          #t))))))
    (let loop ((i 0) (result '()))
      (if (= i n)
          (reverse result)
          (begin
            (dfs i)
            (if (vector-ref safe? i)
                (loop (+ i 1) (cons i result))
                (loop (+ i 1) result)))))))