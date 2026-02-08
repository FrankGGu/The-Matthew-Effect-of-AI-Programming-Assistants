(define (destroy-sequential-targets nums space)
  (define counts (make-hash))

  (for-each (lambda (num)
              (define remainder (modulo num space))
              (hash-update! counts remainder add1 0))
            nums)

  (define max-count 0)
  (define min-x (car nums)) ; nums is guaranteed to be non-empty by constraints

  (for-each (lambda (num)
              (define remainder (modulo num space))
              (define current-count (hash-ref counts remainder 0))

              (when (> current-count max-count)
                (set! max-count current-count)
                (set! min-x num))

              (when (and (= current-count max-count) (< num min-x))
                (set! min-x num)))
            nums)

  min-x)