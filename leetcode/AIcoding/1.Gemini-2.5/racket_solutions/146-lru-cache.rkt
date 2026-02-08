#lang racket

(struct node (key val prev next) #:mutable)

(struct lru-cache (capacity size map head tail) #:mutable)

(define (add-node-to-tail! cache-obj node-to-add)
  (let* ((tail-node (lru-cache-tail cache-obj))
         (prev-of-tail (node-prev tail-node)))
    (set-node-prev! node-to-add prev-of-tail)
    (set-node-next! node-to-add tail-node)
    (set-node-next! prev-of-tail node-to-add)
    (set-node-prev! tail-node node-to-add)))

(define (remove-node! cache-obj node-to-remove)
  (let* ((prev-node (node-prev node-to-remove))
         (next-node (node-next node-to-remove)))
    (set-node-next! prev-node next-node)
    (set-node-prev! next-node prev-node)))

(define (move-to-tail! cache-obj node-to-move)
  (remove-node! cache-obj node-to-move)
  (add-node-to-tail! cache-obj node-to-move))

(define (LRUCache capacity)
  (define head (node #f #f #f #f))
  (define tail (node #f #f #f #f))
  (set-node-next! head tail)
  (set-node-prev! tail head)
  (lru-cache capacity 0 (make-hash) head tail))

(define (get cache-obj key)
  (let ((cache-map (lru-cache-map cache-obj)))
    (define node-found (hash-ref cache-map key #f))
    (if node-found
        (begin
          (move-to-tail! cache-obj node-found)
          (node-val node-found))
        -1)))

(define (put cache-obj key value)
  (let ((cache-map (lru-cache-map cache-obj))
        (current-size (lru-cache-size cache-obj))
        (capacity (lru-cache-capacity cache-obj)))
    (define node-found (hash-ref cache-map key #f))
    (if node-found
        (begin
          (set-node-val! node-found value)
          (move-to-tail! cache-obj node-found))
        (begin
          (define new-node (node key value #f #f))
          (hash-set! cache-map key new-node)
          (add-node-to-tail! cache-obj new-node)
          (set-lru-cache-size! cache-obj (+ current-size 1))
          (when (> (lru-cache-size cache-obj) capacity)
            (define lru-node (node-next (lru-cache-head cache-obj)))
            (remove-node! cache-obj lru-node)
            (hash-remove! cache-map (node-key lru-node))
            (set-lru-cache-size! cache-obj (- (lru-cache-size cache-obj) 1)))))))