(define (max-operations nums k)
  (define freq (make-hash))
  (define operations 0)

  (for-each (lambda (num)
              (define complement (- k num))
              (define complement-count (hash-ref freq complement 0))

              (if (> complement-count 0)
                  (begin
                    (set! operations (+ operations 1))
                    (hash-set! freq complement (- complement-count 1)))
                  (begin
                    (define num-count (hash-ref freq num 0))
                    (hash-set! freq num (+ num-count 1)))))
            nums)

  operations)