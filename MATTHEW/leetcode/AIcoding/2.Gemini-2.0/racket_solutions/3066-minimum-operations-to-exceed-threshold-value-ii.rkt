(define (minOperations nums k)
  (let* ([h (make-heap < #:mutable? #t)]
         (add-all (lambda (lst)
                    (for-each (lambda (x) (heap-add! h x)) lst)))
         (ops (mutable-box 0)))
    (add-all nums)
    (let loop ()
      (if (heap-top h)
          (if (>= (heap-top h) k)
              (box-unbox ops)
              (if (< (heap-count h) 2)
                  -1
                  (let* ([x (heap-remove-top! h)]
                         [y (heap-remove-top! h)]
                         [new-val (min k (+ x (* 2 y)))])
                    (heap-add! h new-val)
                    (box-set! ops (+ (box-unbox ops) 1))
                    (loop))))
          (box-unbox ops)))))