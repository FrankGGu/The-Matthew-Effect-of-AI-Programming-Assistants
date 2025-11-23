(define-struct node (key val prev next) #:mutable #:transparent)

(define LRUCache%
  (class object%
    (super-new)
    (init-field capacity)
    (field [size 0]
           [head (make-node -1 -1 #f #f)]
           [tail (make-node -1 -1 #f #f)]
           [cache (make-hash)])

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
              (set! size (add1 size))
              (when (> size capacity)
                (let ([removed (remove-tail)])
                  (hash-remove! cache (node-key removed))
                  (set! size (sub1 size))))))))

    (define (add-node node)
      (set-node-prev! node head)
      (set-node-next! node (node-next head))
      (when (node-next head)
        (set-node-prev! (node-next head) node))
      (set-node-next! head node))

    (define (remove-node node)
      (let ([prev (node-prev node)]
            [next (node-next node)])
        (set-node-next! prev next)
        (when next
          (set-node-prev! next prev))))

    (define (move-to-head node)
      (remove-node node)
      (add-node node))

    (define (remove-tail)
      (let ([res (node-prev tail)])
        (remove-node res)
        res))

    (send this init)

    (define/public (init)
      (set-node-next! head tail)
      (set-node-prev! tail head))))

(define (make-lru-cache capacity)
  (new LRUCache% [capacity capacity]))