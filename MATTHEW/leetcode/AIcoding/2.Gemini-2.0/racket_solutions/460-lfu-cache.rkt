(define (make-lfu-cache capacity)
  (let ([capacity capacity]
        [cache (make-hash)]
        [freq (make-hash)]
        [min-freq 1])
    (define (update-freq key)
      (let ([old-freq (hash-ref cache key #f)])
        (hash-update freq old-freq (lambda (x) (remove key x)) '())
        (when (and (= old-freq min-freq) (empty? (hash-ref freq old-freq '())))
          (set! min-freq (+ min-freq 1)))
        (let ([new-freq (+ old-freq 1)])
          (hash-update! cache key new-freq)
          (hash-update! freq new-freq (lambda (x) (cons key x)) (list key)))))
    (define (get key)
      (if (hash-has-key? cache key)
          (let ([value (cadr (hash-ref cache key))])
            (update-freq key)
            value)
          -1))
    (define (put key value)
      (if (= capacity 0)
          #f
          (if (hash-has-key? cache key)
              (begin
                (hash-update! cache key (lambda (x) (list (car x) value)))
                (update-freq key))
              (begin
                (when (= (hash-count cache) capacity)
                  (let ([evict-key (car (hash-ref freq min-freq '()))])
                    (hash-remove! cache evict-key)
                    (hash-update! freq min-freq (lambda (x) (remove evict-key x)) '())))
                (hash-set! cache key (list 1 value))
                (hash-update! freq 1 (lambda (x) (cons key x)) (list key))
                (set! min-freq 1)))))
    (define (dispatch method . args)
      (case method
        [(get) (apply get args)]
        [(put) (apply put args)]
        [else (error "Invalid method")]))
    dispatch))