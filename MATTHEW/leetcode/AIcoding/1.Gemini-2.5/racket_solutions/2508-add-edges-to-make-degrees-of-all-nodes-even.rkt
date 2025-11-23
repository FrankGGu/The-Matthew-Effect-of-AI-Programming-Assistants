(define (can-make-degrees-even n edges)
  (define degrees (make-hash))
  (for ([i (range 1 (+ n 1))])
    (hash-set! degrees i 0))

  (define adj-set (make-hash-set))

  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (hash-update! degrees u add1)
              (hash-update! degrees v add1)
              (hash-set-add! adj-set (list (min u v) (max u v))))
            edges)

  (define odd-degree-nodes
    (for/list ([i (range 1 (+ n 1))]
               #:when (odd? (hash-ref degrees i)))
      i))

  (define num-odd-nodes (length odd-degree-nodes))

  (define (edge-exists? u v)
    (hash-set-contains? adj-set (list (min u v) (max u v))))

  (case num-odd-nodes
    [0 #t]
    [2 #t]
    [4 (let ([a (list-ref odd-degree-nodes 0)]
             [b (list-ref odd-degree-nodes 1)]
             [c (list-ref odd-degree-nodes 2)]
             [d (list-ref odd-degree-nodes 3)])
         (or (and (not (edge-exists? a b)) (not (edge-exists? c d)))
             (and (not (edge-exists? a c)) (not (edge-exists? b d)))
             (and (not (edge-exists? a d)) (not (edge-exists? b c)))))]
    [else #f]))