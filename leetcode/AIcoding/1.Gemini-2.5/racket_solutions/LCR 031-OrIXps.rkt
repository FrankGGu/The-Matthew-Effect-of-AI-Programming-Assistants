(struct node (key value prev next) #:mutable)
(struct lru-cache (capacity cache-map head tail) #:mutable)

(define (add-node cache node)
  (define head (lru-cache-head cache))
  (define next-node (node-next head))

  (set-node-prev! node head)
  (set-node-next! node next-node)
  (set-node-next! head node)
  (set-node-prev! next-node node))

(define (remove-node node)
  (define prev-node (node-prev node))
  (define next-node (node-next node))

  (set-node-next! prev-node next-node)
  (set-node-prev! next-node prev-node))

(define (move-node-to-front cache node)
  (remove-node node)
  (add-node cache node))

(define (remove-tail-node cache)
  (define tail (lru-cache-tail cache))
  (define lru-node (node-prev tail))
  (remove-node lru-node)
  lru-node)

(define (lRUCache-init capacity)
  (define head (node #f #f #f #f))
  (define tail (node #f #f #f #f))
  (set-node-next! head tail)
  (set-node-prev! tail head)
  (lru-cache capacity (make-hash) head tail))

(define (lRUCache-get obj key)
  (define cache-map (lru-cache-cache-map obj))
  (define node (hash-ref cache-map key #f))
  (if node
      (begin
        (move-node-to-front obj node)
        (node-value node))
      -1))

(define (lRUCache-put obj key value)
  (define cache-map (lru-cache-cache-map obj))
  (define capacity (lru-cache-capacity obj))
  (define node (hash-ref cache-map key #f))

  (if node
      (begin
        (set-node-value! node value)
        (move-node-to-front obj node))
      (begin
        (define new-node (node key value #f #f))
        (hash-set! cache-map key new-node)
        (add-node obj new-node)

        (when (> (hash-count cache-map) capacity)
          (define lru-node (remove-tail-node obj))
          (hash-remove! cache-map (node-key lru-node))))))