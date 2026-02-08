(define (reachable-nodes graph max-moves n)
  (define adj (make-vector n '()))
  (for ([edge graph])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (vector-set! adj u (cons (list v w) (vector-ref adj u)))
      (vector-set! adj v (cons (list u w) (vector-ref adj v)))))

  (define dist (make-vector n #f))
  (vector-set! dist 0 0)

  (define pq (make-heap < #:key (λ (x) (vector-ref dist (car x)))))
  (heap-add! pq (cons 0 0))

  (define visited (make-hash))
  (define ans 0)

  (define (dijkstra)
    (when (not (heap-empty? pq))
      (let* ([curr (heap-remove-min! pq)]
             [u (car curr)]
             [d (cdr curr)])
        (unless (hash-has-key? visited u)
          (hash-set! visited u #t)
          (set! ans (+ ans 1))
          (for ([neighbor (vector-ref adj u)])
            (let* ([v (car neighbor)]
                   [w (cadr neighbor)]
                   [new-dist (+ d w 1)])
              (when (and (or (not (vector-ref dist v)) (< new-dist (vector-ref dist v)))
                         (<= new-dist max-moves))
                (vector-set! dist v new-dist)
                (heap-add! pq (cons v new-dist))))))
        (dijkstra))))

  (dijkstra)

  (define edge-count 0)
  (for ([edge graph])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (let ([moves-u (or (vector-ref dist u) max-moves)]
            [moves-v (or (vector-ref dist v) max-moves)])
        (set! edge-count (+ edge-count (min w (+ (max 0 (- max-moves moves-u)) (max 0 (- max-moves moves-v))))))))

  (+ ans edge-count))