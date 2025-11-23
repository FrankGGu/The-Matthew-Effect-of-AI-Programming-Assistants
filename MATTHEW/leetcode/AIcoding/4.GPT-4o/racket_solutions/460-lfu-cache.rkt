(define LFUCache
  (lambda (capacity)
    (let ([cache (make-hash)]
          [freq (make-hash)]
          [min-freq 0]
          [size 0])
      (define (update-key key value)
        (let* ([node (hash-ref cache key)]
               [old-freq (hash-ref node 'freq)]
               [new-freq (add1 old-freq)])
          (hash-set! cache key (hash-set node 'freq new-freq 'value value))
          (hash-set! (hash-ref freq old-freq) key #f)
          (if (hash-ref (hash-ref freq old-freq) key)
              (when (null? (hash-ref (hash-ref freq old-freq) key))
                (hash-remove! freq old-freq)))
          (hash-set! freq new-freq (cons key (hash-ref freq new-freq)))
          (when (null? (hash-ref freq min-freq))
            (set! min-freq new-freq)))))

      (define (get-key key)
        (if (hash-has-key? cache key)
            (let ([node (hash-ref cache key)])
              (update-key key (hash-ref node 'value))
              (hash-ref node 'value))
            -1))

      (define (put-key key value)
        (if (zero? capacity)
            #f
            (if (hash-has-key? cache key)
                (begin
                  (update-key key value))
                (begin
                  (if (= size capacity)
                      (let* ([min-list (hash-ref freq min-freq)]
                             [to-remove (car min-list)])
                        (hash-remove! cache to-remove)
                        (hash-set! freq min-freq (cdr min-list))
                        (set! size (sub1 size))))
                  (hash-set! cache key (hash 'freq 1 'value value))
                  (hash-set! freq 1 (cons key (hash-ref freq 1)))
                  (set! min-freq 1)
                  (set! size (add1 size))))))

      (lambda (cmd & args)
        (cond
          [(equal? cmd 'get) (apply get-key args)]
          [(equal? cmd 'put) (apply put-key args)]
          [else (error "Unknown command")])))))

(define cache (LFUCache 2))
((cache 'put) 1 1)
((cache 'put) 2 2)
((cache 'get) 1) ; returns 1
((cache 'put) 3 3) ; evicts key 2
((cache 'get) 2) ; returns -1 (not found)
((cache 'put) 4 4) ; evicts key 1
((cache 'get) 1) ; returns -1 (not found)
((cache 'get) 3) ; returns 3
((cache 'get) 4) ; returns 4