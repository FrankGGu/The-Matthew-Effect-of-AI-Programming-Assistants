#lang racket

(require data/heap)

(define (max-probability n edges succProb start end)
  ;; Build the graph
  (define graph (make-hash))
  (for ([edge-pair edges]
        [prob succProb])
    (define u (car edge-pair))
    (define v (cadr edge-pair))
    (hash-update! graph u (lambda (lst) (cons (list v prob) lst)) (list))
    (hash-update! graph v (lambda (lst) (cons (list u prob) lst)) (list)))

  ;; Initialize probabilities
  (define probabilities (make-vector n 0.0))
  (vector-set! probabilities start 1.0)

  ;; Priority queue (min-heap storing (list (-probability) node))
  ;; We want to extract the maximum probability first, so we store negative
  ;; probabilities and use a min-heap.
  (define pq (make-heap (lambda (a b) (< (car a) (car b))))) ; Comparator for (list neg-prob node)
  (heap-add! pq (list -1.0 start)) ; Initial state: probability 1.0 for start node

  ;; Dijkstra-like algorithm
  (while (not (heap-empty? pq))
    (define current-entry (heap-extract-min! pq))
    (define current-neg-prob (car current-entry))
    (define current-node (cadr current-entry))
    (define current-prob (- current-neg-prob))

    ;; If the probability extracted from the heap is less than what we currently have
    ;; for this node, it means we've already found a better path to this node.
    ;; So, this entry is stale, skip it.
    (unless (< current-prob (vector-ref probabilities current-node))
      ;; Otherwise, process this node
      (for ([edge (hash-ref graph current-node (list))])
        (define neighbor-node (car edge))
        (define edge-prob (cadr edge))
        (define new-prob (* current-prob edge-prob))

        ;; If we found a better path to the neighbor
        (when (> new-prob (vector-ref probabilities neighbor-node))
          (vector-set! probabilities neighbor-node new-prob)
          (heap-add! pq (list (- new-prob) neighbor-node))))))

  (vector-ref probabilities end))