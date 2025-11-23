#lang racket

(struct dll-node (key prev next) #:mutable)
(struct dll (head tail) #:mutable)

(define (make-dll) (dll #f #f))

(define (dll-add-tail! dll key)
  (define new-node (dll-node key (dll-tail dll) #f))
  (when (dll-tail dll)
    (set-dll-node-next! (dll-tail dll) new-node))
  (set-dll-tail! dll new-node)
  (unless (dll-head dll)
    (set-dll-head! dll new-node))
  new-node)

(define (dll-remove! dll node)
  (define prev-node (dll-node-prev node))
  (define next-node (dll-node-next node))

  (if prev-node
      (set-dll-node-next! prev-node next-node)
      (set-dll-head! dll next-node))

  (if next-node
      (set-dll-node-prev! next-node prev-node)
      (set-dll-tail! dll prev-node)))

(define (dll-is-empty? dll)
  (not (dll-head dll)))

(define (dll-get-head-key dll)
  (dll-node-key (dll-head dll)))

(struct lfu-cache (capacity
                   size
                   min-freq
                   cache-map
                   freq-lists)
  #:mutable)

(define (update-frequency! lfu-cache key value)
  (define cache-entry (hash-ref (lfu-cache-cache-map lfu-cache) key))
  (define old-freq (cadr cache-entry))
  (define old-node (caddr cache-entry))

  (define old-freq-dll (hash-ref (lfu-cache-freq-lists lfu-cache) old-freq))
  (dll-remove! old-freq-dll old-node)

  (when (and (dll-is-empty? old-freq-dll) (= old-freq (lfu-cache-min-freq lfu-cache)))
    (set-lfu-cache-min-freq! lfu-cache (+ (lfu-cache-min-freq lfu-cache) 1)))

  (define new-freq (+ old-freq 1))
  (define new-freq-dll (hash-ref (lfu-cache-freq-lists lfu-cache) new-freq #f))
  (unless new-freq-dll
    (set! new-freq-dll (make-dll))
    (hash-set! (lfu-cache-freq-lists lfu-cache) new-freq new-freq-dll))
  (define new-node (dll-add-tail! new-freq-dll key))

  (hash-set! (lfu-cache-cache-map lfu-cache) key (list value new-freq new-node))
  value)

(define (LFUCache capacity)
  (lfu-cache capacity 0 0 (make-hash) (make-hash)))

(define (LFUCache-get obj key)
  (if (hash-has-key? (lfu-cache-cache-map obj) key)
      (update-frequency! obj key (car (hash-ref (lfu-cache-cache-map obj) key)))
      -1))

(define (LFUCache-put obj key value)
  (when (> (lfu-cache-capacity obj) 0)
    (if (hash-has-key? (lfu-cache-cache-map obj) key)
        (update-frequency! obj key value)
        (begin
          (when (= (lfu-cache-size obj) (lfu-cache-capacity obj))
            (define lfu-dll (hash-ref (lfu-cache-freq-lists obj) (lfu-cache-min-freq obj)))
            (define key-to-evict (dll-get-head-key lfu-dll))
            (dll-remove! lfu-dll (dll-head lfu-dll))
            (hash-remove! (lfu-cache-cache-map obj) key-to-evict)
            (set-lfu-cache-size! obj (- (lfu-cache-size obj) 1)))

          (define new-freq 1)
          (define new-freq-dll (hash-ref (lfu-cache-freq-lists obj) new-freq #f))
          (unless new-freq-dll
            (set! new-freq-dll (make-dll))
            (hash-set! (lfu-cache-freq-lists obj) new-freq new-freq-dll))
          (define new-node (dll-add-tail! new-freq-dll key))
          (hash-set! (lfu-cache-cache-map obj) key (list value new-freq new-node))
          (set-lfu-cache-min-freq! obj 1)
          (set-lfu-cache-size! obj (+ (lfu-cache-size obj) 1))))))