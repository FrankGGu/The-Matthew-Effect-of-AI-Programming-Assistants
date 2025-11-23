(define all-one%
  (class object%
    (super-new)
    (init-field)
    (define key-count (make-hash))
    (define count-keys (make-hash))
    (define max-count 0)
    (define min-count 0)

    (define/public (inc key)
      (let* ([old-count (hash-ref key-count key 0)]
             [new-count (add1 old-count)])
        (hash-set! key-count key new-count)
        (when (> old-count 0)
          (hash-update! count-keys old-count (λ (keys) (set-remove keys key)) (when (set-empty? (hash-ref count-keys old-count)) (hash-remove! count-keys old-count))))
        (hash-update! count-keys new-count (λ (keys) (set-add keys key)) (void))
      (set! max-count (max max-count (hash-ref key-count key 0)))
      (when (or (zero? min-count) (< (hash-ref key-count key 0) min-count))
        (set! min-count (hash-ref key-count key 0))))

    (define/public (dec key)
      (let* ([old-count (hash-ref key-count key 0)]
             [new-count (sub1 old-count)])
        (when (> old-count 0)
          (hash-update! count-keys old-count (λ (keys) (set-remove keys key)) (when (set-empty? (hash-ref count-keys old-count)) (hash-remove! count-keys old-count))))
        (when (> new-count 0)
          (hash-set! key-count key new-count)
          (hash-update! count-keys new-count (λ (keys) (set-add keys key)))
          (when (< new-count min-count) (set! min-count new-count)))
        (when (zero? new-count) (hash-remove! key-count key)))
      (when (and (> old-count 0) (hash-empty? (hash-ref count-keys max-count #f)))
        (set! max-count (if (hash-empty? count-keys) 0 (apply max (hash-keys count-keys))))
      (when (and (> old-count 0) (hash-empty? (hash-ref count-keys min-count #f)))
        (set! min-count (if (hash-empty? count-keys) 0 (apply min (hash-keys count-keys)))))

    (define/public (get-max-key)
      (if (zero? max-count) "" (car (set->list (hash-ref count-keys max-count)))))

    (define/public (get-min-key)
      (if (zero? min-count) "" (car (set->list (hash-ref count-keys min-count)))))))