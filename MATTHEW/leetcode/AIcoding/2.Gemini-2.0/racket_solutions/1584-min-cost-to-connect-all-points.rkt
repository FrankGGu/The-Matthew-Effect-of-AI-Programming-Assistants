(define (min-cost-connect-points points)
  (let* ([n (length points)]
         [adj-list (make-vector n '())]
         [visited (make-vector n #f)]
         [pq (make-heap < #:key (lambda (edge) (car edge)))]
         [total-cost 0])

    (define (manhattan-distance p1 p2)
      (+ (abs (- (vector-ref p1 0) (vector-ref p2 0)))
         (abs (- (vector-ref p1 1) (vector-ref p2 1)))))

    (for ([i (in-range n)])
      (for ([j (in-range i 1 n)])
        (let ([dist (manhattan-distance (vector-ref points i) (vector-ref points j))])
          (set-vector! adj-list i (cons (cons dist j) (vector-ref adj-list i)))
          (set-vector! adj-list j (cons (cons dist i) (vector-ref adj-list j))))))

    (vector-set! visited 0 #t)
    (for ([edge (in-list (vector-ref adj-list 0))])
      (heap-add! pq edge))

    (for ([_ (in-range (- n 1))])
      (let loop ()
        (if (heap-empty? pq)
            (void)
            (let* ([edge (heap-remove-min! pq)]
                   [cost (car edge)]
                   [node (cdr edge)])
              (if (vector-ref visited node)
                  (loop)
                  (begin
                    (set! total-cost (+ total-cost cost))
                    (vector-set! visited node #t)
                    (for ([next-edge (in-list (vector-ref adj-list node))])
                      (let ([next-node (cdr next-edge)])
                        (unless (vector-ref visited next-node)
                          (heap-add! pq next-edge))))))))))

    total-cost))