#lang racket

(define (count-pairs-of-connectable-servers n edges signalSpeed)
  (define adj (make-vector n '()))

  ;; Build adjacency list
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
              (vector-set! adj v (cons (cons u w) (vector-ref adj v))))
            edges)

  (define ans (make-vector n 0))

  ;; DFS function to count connectable servers in a subtree
  (define (dfs-count u parent current-dist)
    (define count (if (zero? (modulo current-dist signalSpeed)) 1 0))
    (for-each (lambda (edge-pair)
                (define v (car edge-pair))
                (define w (cdr edge-pair))
                (when (not (= v parent))
                  (set! count (+ count (dfs-count v u (+ current-dist w))))))
              (vector-ref adj u))
    count)

  ;; Iterate through each node as the center server
  (for ([i (in-range n)])
    (define branch-counts '())
    (define current-center-pairs 0)
    (define running-sum 0)

    ;; For each neighbor of the current center 'i'
    (for-each (lambda (edge-pair)
                (define neighbor-j (car edge-pair))
                (define weight-ij (cdr edge-pair))
                (define dfs-result (dfs-count neighbor-j i weight-ij))
                (set! branch-counts (cons dfs-result branch-counts)))
              (vector-ref adj i))

    ;; Calculate pairs from different branches
    (for-each (lambda (c)
                (set! current-center-pairs (+ current-center-pairs (* running-sum c)))
                (set! running-sum (+ running-sum c)))
              (reverse branch-counts)) ; Process in a consistent order

    (vector-set! ans i current-center-pairs))

  (vector->list ans))