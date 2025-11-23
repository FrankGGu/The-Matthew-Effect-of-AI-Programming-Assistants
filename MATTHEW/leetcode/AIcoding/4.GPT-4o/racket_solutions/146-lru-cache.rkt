(define LRUCache
  (lambda (capacity)
    (define cache (make-hash))
    (define order '())

    (define (get key)
      (if (hash-has-key? cache key)
          (begin
            (set! order (remove (lambda (x) (equal? x key)) order))
            (set! order (cons key order))
            (hash-ref cache key)
          )
          -1))

    (define (put key value)
      (if (hash-has-key? cache key)
          (begin
            (hash-set! cache key value)
            (set! order (remove (lambda (x) (equal? x key)) order))
            (set! order (cons key order)))
          (begin
            (if (= (length order) capacity)
                (begin
                  (hash-remove! cache (car (reverse order)))
                  (set! order (cdr (reverse order)))))
            (hash-set! cache key value)
            (set! order (cons key order)))))

    (define (get-method) get)
    (define (put-method) put)

    (define (methods)
      (list
        (lambda () (get-method))
        (lambda () (put-method))))

    (methods)))