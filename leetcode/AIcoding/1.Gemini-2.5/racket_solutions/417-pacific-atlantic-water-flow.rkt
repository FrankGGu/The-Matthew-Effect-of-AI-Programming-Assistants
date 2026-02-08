#lang racket

(define (pacific-atlantic heights)
  (define m (length heights))
  (define n (length (car heights)))

  (define pacific-reachable (make-vector m (lambda () (make-vector n #f))))
  (define atlantic-reachable (make-vector m (lambda () (make-vector n #f))))

  (define (dfs-explore row col prev-height visited-matrix)
    (when (and (>= row 0) (< row m)
               (>= col 0) (< col n)
               (not (vector-ref (vector-ref visited-matrix row) col)))
      (let ([current-cell-height (list-ref (list-ref heights row) col)])
        (when (>= current-cell-height prev-height)
          (vector-set! (vector-ref visited-matrix row) col #t)
          (dfs-explore (+ row 0) (+ col 1) current-cell-height visited-matrix)
          (dfs-explore (+ row 0) (+ col -1) current-cell-height visited-matrix)
          (dfs-explore (+ row 1) (+ col 0) current-cell-height visited-matrix)
          (dfs-explore (+ row -1) (+ col 0) current-cell-height visited-matrix))))))

  ;; Start DFS from Pacific border cells
  (for ([r (in-range m)])
    (dfs-explore r 0 (list-ref (list-ref heights r) 0) pacific-reachable))
  (for ([c (in-range n)])
    (dfs-explore 0 c (list-ref (list-ref heights 0) c) pacific-reachable))

  ;; Start DFS from Atlantic border cells
  (for ([r (in-range m)])
    (dfs-explore r (- n 1) (list-ref (list-ref heights r) (- n 1)) atlantic-reachable))
  (for ([c (in-range n)])
    (dfs-explore (- m 1) c (list-ref (list-ref heights (- m 1)) c) atlantic-reachable))

  ;; Collect results
  (define result '())
  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (when (and (vector-ref (vector-ref pacific-reachable r) c)
                 (vector-ref (vector-ref atlantic-reachable r) c))
        (set! result (cons (list r c) result)))))
  (reverse result))