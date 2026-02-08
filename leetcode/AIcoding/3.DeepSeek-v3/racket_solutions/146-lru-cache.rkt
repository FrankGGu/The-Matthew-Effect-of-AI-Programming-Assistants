(define-struct node (key val prev next) #:mutable #:transparent)

(define LRUCache%
  (class object%
    (super-new)
    (init-field capacity)
    (field [cache (make-hash)]
           [head (make-node -1 -1 #f #f)]
           [tail (make-node -1 -1 #f #f)])

    (define/public (init)
      (set-node-next! head tail)
      (set-node-prev! tail head))

    (define/public (add-node node)
      (let ([next (node-next head)])
        (set-node-next! head node)
        (set-node-prev! node head)
        (set-node-next! node next)
        (set-node-prev! next node)))

    (define/public (remove-node node)
      (let ([prev (node-prev node)]
            [next (node-next node)])
        (set-node-next! prev next)
        (set-node-prev! next prev)))

    (define/public (move-to-head node)
      (remove-node node)
      (add-node node))

    (define/public (pop-tail)
      (let ([node (node-prev tail)])
        (remove-node node)
        node))

    (define/public (get key)
      (if (hash-has-key? cache key)
          (let ([node (hash-ref cache key)])
            (move-to-head node)
            (node-val node))
          -1))

    (define/public (put key value)
      (if (hash-has-key? cache key)
          (let ([node (hash-ref cache key)])
            (set-node-val! node value)
            (move-to-head node))
          (begin
            (let ([node (make-node key value #f #f)])
              (hash-set! cache key node)
              (add-node node)
              (when (> (hash-count cache) capacity)
                (let ([tail (pop-tail)])
                  (hash-remove! cache (node-key tail)))))))

    (init)))

(define (make-lru-cache capacity)
  (new LRUCache% [capacity capacity]))