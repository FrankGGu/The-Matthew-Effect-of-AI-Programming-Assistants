#lang racket

(require racket/hash)

(define (electric-car-tour-city n roads start-node end-node)
  ;; Graph representation: hash table from node to list of (neighbor weight) pairs
  (define graph (make-hash))
  (for-each
   (lambda (road)
     (define u (car road))
     (define v (cadr road))
     (define w (caddr road))
     (hash-set! graph u (cons (list v w) (hash-ref graph u '())))
     (hash-set! graph v (cons (list u w) (hash-ref graph v '())))) ; Assuming undirected graph
   roads)

  ;; Distance map: hash table from node to minimum cost
  (define dist (make-hash))
  (for-each (lambda (i) (hash-set! dist i +inf.0)) (range 1 (+ n 1))) ; Nodes are 1-indexed
  (hash-set! dist start-node 0)

  ;; Priority Queue: a list of (cost . node) pairs, kept sorted by cost
  ;; Using a simple sorted list for PQ. This can be slow (O(V*E) worst case)
  ;; but might pass for smaller constraints or sparse graphs.
  (define pq (list (cons 0 start-node))) ; (cost . node)

  ;; Helper to insert an item into the sorted priority queue
  (define (insert-sorted-pq lst item)
    (cond
      ((empty? lst) (list item))
      ((<= (car item) (caar lst)) (cons item lst)) ; Insert at head if item's cost is less or equal
      (else (cons (car lst) (insert-sorted-pq (cdr lst) item)))))

  (let loop ((current-pq pq))
    (when (not (empty? current-pq))
      (define current-entry (car current-pq))
      (define current-cost (car current-entry))
      (define u (cdr current-entry))
      (define rest-pq (cdr current-pq))

      ;; If we've found a shorter path to 'u' already, skip this entry
      ;; This check is crucial for efficiency with a non-heap priority queue
      (when (< current-cost (hash-ref dist u))
        (loop rest-pq))

      (for-each
       (lambda (neighbor-info)
         (define v (car neighbor-info))
         (define weight (cadr neighbor-info))
         (define new-cost (+ current-cost weight))

         (when (< new-cost (hash-ref dist v))
           (hash-set! dist v new-cost)
           ;; Insert new entry into the priority queue, maintaining sorted order
           (set! rest-pq (insert-sorted-pq rest-pq (cons new-cost v)))))
       (hash-ref graph u '())) ; Get neighbors of u, default to empty list if u not in graph

      (loop rest-pq)))

  (define result (hash-ref dist end-node))
  (if (= result +inf.0) -1 result)) ; Return -1 if end-node is unreachable