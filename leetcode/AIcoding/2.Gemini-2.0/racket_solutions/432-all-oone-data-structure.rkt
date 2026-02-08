(define (AllOne)
  (let ((string->count (make-hash))
        (count->strings (make-hash))
        (min-count 0)
        (max-count 0))

    (define (inc s)
      (let* ((old-count (hash-ref string->count s 0))
             (new-count (+ old-count 1)))

        (hash-set! string->count s new-count)

        (when (> old-count 0)
          (let ((strings (hash-ref count->strings old-count)))
            (hash-set! count->strings old-count (remove s strings))
            (when (empty? (hash-ref count->strings old-count))
              (hash-remove! count->strings old-count)
              (when (= old-count min-count)
                (set! min-count new-count)))))

        (hash-set! count->strings new-count (cons s (hash-ref count->strings new-count '())))

        (set! max-count (max max-count new-count))
        (when (= old-count 0)
          (set! min-count 1))
        ))

    (define (dec s)
      (let* ((old-count (hash-ref string->count s 0))
             (new-count (- old-count 1)))

        (hash-set! string->count s new-count)

        (let ((strings (hash-ref count->strings old-count)))
          (hash-set! count->strings old-count (remove s strings))
          (when (empty? (hash-ref count->strings old-count))
            (hash-remove! count->strings old-count)
            (when (= old-count max-count)
              (set! max-count new-count))))

        (when (> new-count 0)
          (hash-set! count->strings new-count (cons s (hash-ref count->strings new-count '()))))

        (when (= new-count 0)
          (hash-remove! string->count s))

        (when (= old-count min-count)
          (let loop ((i min-count))
            (cond
              [(not (hash-has-key? count->strings i))
               (if (< i max-count)
                   (loop (+ i 1))
                   (set! min-count max-count))]
              [else
               (set! min-count i)])))

        (when (= new-count 0)
          (when (= min-count max-count)
            (set! min-count 0)
            (set! max-count 0)))
        ))

    (define (getMaxKey)
      (if (zero? max-count)
          ""
          (car (hash-ref count->strings max-count))))

    (define (getMinKey)
      (if (zero? min-count)
          ""
          (car (hash-ref count->strings min-count))))

    (struct allone-methods (inc dec getMaxKey getMinKey))
    (allone-methods inc dec getMaxKey getMinKey)))