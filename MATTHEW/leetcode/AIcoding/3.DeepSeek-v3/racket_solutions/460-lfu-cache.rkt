(define LFUCache%
  (class object%
    (super-new)
    (init-field capacity)

    (define count 0)
    (define min-freq 1)
    (define key-val (make-hash))
    (define key-freq (make-hash))
    (define freq-keys (make-hash))

    (define/public (get key)
      (if (hash-has-key? key-val key)
          (let ([val (hash-ref key-val key)]
                [freq (hash-ref key-freq key)])
            (update-freq key freq)
            val)
          -1))

    (define/public (put key value)
      (when (> capacity 0)
        (if (hash-has-key? key-val key)
            (begin
              (hash-set! key-val key value)
              (let ([freq (hash-ref key-freq key)])
                (update-freq key freq))
            (begin
              (when (= count capacity)
                (let* ([keys (hash-ref freq-keys min-freq)]
                       [del-key (car keys)])
                  (hash-remove! key-val del-key)
                  (hash-remove! key-freq del-key)
                  (hash-set! freq-keys min-freq (cdr keys))
                  (when (null? (hash-ref freq-keys min-freq))
                    (hash-remove! freq-keys min-freq))
                  (set! count (- count 1))))
              (hash-set! key-val key value)
              (hash-set! key-freq key 1)
              (hash-update! freq-keys 1 (lambda (lst) (cons key lst)) '())
              (set! min-freq 1)
              (set! count (+ count 1))))))

    (define (update-freq key freq)
      (let* ([keys (hash-ref freq-keys freq)]
             [new-keys (remove key keys)])
        (hash-set! freq-keys freq new-keys)
        (when (null? new-keys)
          (hash-remove! freq-keys freq)
          (when (= freq min-freq)
            (set! min-freq (+ min-freq 1))))
        (hash-set! key-freq key (+ freq 1))
        (hash-update! freq-keys (+ freq 1) (lambda (lst) (cons key lst)) '())))
))