#lang racket

(require racket/set)
(require racket/hash)
(require srfi/1) ; for list-sort
(require racket/control) ; for let/ec

(define (number-of-ways-to-reconstruct-a-tree pairs)
  (define adj (make-hash)) ; node -> set of neighbors
  (define all-nodes (set))

  (for-each (lambda (pair)
              (define u (car pair))
              (define v (cadr pair))
              (hash-update! adj u (lambda (s) (set-add s v)) (set))
              (hash-update! adj v (lambda (s) (set-add s u)) (set))
              (set! all-nodes (set-add all-nodes u))
              (set! all-nodes (set-add all-nodes v)))
            pairs)

  (define N (set-count all-nodes))

  (let/ec return
    (when (<= N 1)
      (if (empty? pairs)
          (return 1)
          (return 0)))

    (define S (make-hash)) ; node -> set of nodes in its "subtree" (itself + all neighbors)
    (for-each (lambda (node)
                (define neighbors (hash-ref adj node (set)))
                (hash-set! S node (set-add neighbors node)))
              (set->list all-nodes))

    (define nodes-by-size
      (list-sort (lambda (node1 node2)
                   (> (set-count (hash-ref S node1))
                      (set-count (hash-ref S node2))))
                 (set->list all-nodes)))

    (define root (car nodes-by-size))
    (when (not (= (set-count (hash-ref S root)) N))
      (return 0))

    (define num-ways 1)

    (for ((i (in-range 1 N)))
      (define u (list-ref nodes-by-size i))

      (define parent-candidates '())
      (for ((j (in-range i)))
        (define v (list-ref nodes-by-size j))
        (when (set-member? u (hash-ref adj v (set)))
          (when (set-subset? (hash-ref S u) (hash-ref S v))
            (set! parent-candidates (cons v parent-candidates)))))

      (when (empty? parent-candidates)
        (return 0))

      (define min-parent-S-size +inf.0)
      (for-each (lambda (p-cand)
                  (define current-S-p-cand-size (set-count (hash-ref S p-cand)))
                  (when (< current-S-p-cand-size min-parent-S-size)
                    (set! min-parent-S-size current-S-p-cand-size)))
                parent-candidates)

      (define actual-parents-with-min-size '())
      (for-each (lambda (p-cand)
                  (when (= (set-count (hash-ref S p-cand)) min-parent-S-size)
                    (set! actual-parents-with-min-size (cons p-cand actual-parents-with-min-size))))
                parent-candidates)

      (when (> (length actual-parents-with-min-size) 1)
        (return 0))

      (define actual-parent (car actual-parents-with-min-size))

      (define u-adj-without-parent (set-remove (hash-ref adj u) actual-parent))
      (when (not (set-subset? u-adj-without-parent (hash-ref adj actual-parent)))
        (return 0))

      (when (set-equal? (hash-ref S u) (hash-ref S actual-parent))
        (set! num-ways 2)))
    num-ways))