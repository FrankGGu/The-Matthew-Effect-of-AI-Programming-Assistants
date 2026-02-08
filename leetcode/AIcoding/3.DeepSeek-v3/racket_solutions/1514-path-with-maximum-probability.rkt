(define (maxProbability n edges succProb start end)
  (let* ([graph (make-hash)]
         [prob (make-hash)]
         [heap (make-heap (lambda (a b) (> (car a) (car b))))]
         [visited (make-hash)])
    (for ([i (in-range (length edges))])
      (let ([u (list-ref (list-ref edges i) 0)]
            [v (list-ref (list-ref edges i) 1)]
            [p (list-ref succProb i)])
        (hash-update! graph u (lambda (lst) (cons v lst)) '())
        (hash-update! graph v (lambda (lst) (cons u lst)) '())
        (hash-update! prob (cons u v) (lambda (_) p) 0)
        (hash-update! prob (cons v u) (lambda (_) p) 0)))
    (heap-add! heap (cons 1.0 start))
    (let loop ()
      (if (heap-empty? heap)
          0.0
          (let ([current (heap-remove! heap)])
            (let ([current-prob (car current)]
                  [current-node (cdr current)])
              (if (equal? current-node end)
                  current-prob
                  (begin
                    (unless (hash-has-key? visited current-node)
                      (hash-set! visited current-node #t)
                      (for ([neighbor (hash-ref graph current-node '())])
                        (let ([new-prob (* current-prob (hash-ref prob (cons current-node neighbor) 0.0))])
                          (heap-add! heap (cons new-prob neighbor)))))
                    (loop)))))))))