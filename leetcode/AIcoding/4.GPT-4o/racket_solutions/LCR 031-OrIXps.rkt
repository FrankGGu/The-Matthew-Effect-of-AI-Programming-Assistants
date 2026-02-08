#lang racket

(define LRUCache
  (class object%
    (init capacity)
    (define/override (send this get key)
      (if (hash-has-key? cache key)
          (begin
            (define value (hash-ref cache key))
            (hash-remove! cache key)
            (hash-set! cache key value)
            value)
          -1))

    (define/override (send this put key value)
      (if (hash-has-key? cache key)
          (begin
            (hash-remove! cache key)
            (hash-set! cache key value))
          (begin
            (when (>= (hash-count cache) capacity)
              (define oldest-key (car (hash-keys cache)))
              (hash-remove! cache oldest-key)))
            (hash-set! cache key value)))

    (define cache (hash))
    (define capacity capacity)))

(define (make-LRUCache capacity)
  (new LRUCache [capacity capacity]))