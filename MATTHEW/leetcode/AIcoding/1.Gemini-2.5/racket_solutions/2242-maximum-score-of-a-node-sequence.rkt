(define (maximum-score scores edges)
  (define n (vector-length scores))
  (define adj (make-vector n '()))

  ;; Build adjacency list where each element is a list of (neighbor-score neighbor-node) pairs.
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons (list (vector-ref scores v) v) (vector-ref adj u)))
              (vector-set! adj v (cons (list (vector-ref scores u) u) (vector-ref adj v))))
            edges)

  ;; For each node, sort its neighbors by score (descending) and keep only the top K.
  ;; K=3 is generally sufficient to handle cases where top candidates are not valid due to distinctness constraints.
  (define K 3)
  (define top-k-adj (make-vector n '()))
  (for ([i (in-range n)])
    (define neighbors (vector-ref adj i))
    (define sorted-neighbors (sort neighbors (lambda (a b) (> (car a) (car b)))))
    (vector-set! top-k-adj i (take sorted-neighbors (min K (length sorted-neighbors)))))

  (define max-total-score -1)

  ;; Iterate through each edge (b, c) as the middle segment of the a-b-c-d path.
  (for-each (lambda (edge)
              (define b (car edge))
              (define c (cadr edge))

              ;; Iterate through top K neighbors of b to find node 'a'.
              (for-each (lambda (a-info)
                          (define score-a (car a-info))
                          (define a (cadr a-info))

                          ;; 'a' must be distinct from 'c'.
                          (when (not (= a c))
                            ;; Iterate through top K neighbors of c to find node 'd'.
                            (for-each (lambda (d-info)
                                        (define score-d (car d-info))
                                        (define d (cadr d-info))

                                        ;; 'd' must be distinct from 'b'.
                                        ;; 'a' must be distinct from 'd'.
                                        (when (and (not (= d b))
                                                   (not (= a d)))
                                          ;; All four nodes (a, b, c, d) are distinct.
                                          ;; Calculate current path score.
                                          (define current-score
                                            (+ (vector-ref scores a)
                                               (vector-ref scores b)
                                               (vector-ref scores c)
                                               (vector-ref scores d)))
                                          ;; Update maximum score found so far.
                                          (set! max-total-score (max max-total-score current-score))))
                                      (vector-ref top-k-adj c))))
                        (vector-ref top-k-adj b)))
            edges)

  max-total-score)