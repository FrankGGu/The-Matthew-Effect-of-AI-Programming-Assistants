(define (total-fruit fruits)
  (define n (vector-length fruits))
  (when (zero? n)
    (pure-return 0))

  (define left 0)
  (define max-len 0)
  (define counts (make-hash)) ; Stores fruit_type -> count

  (for ([right (in-range n)])
    (define current-fruit (vector-ref fruits right))
    (hash-update! counts current-fruit add1 0)

    (while (> (hash-count counts) 2)
      (define left-fruit (vector-ref fruits left))
      (hash-update! counts left-fruit sub1)
      (when (zero? (hash-ref counts left-fruit))
        (hash-remove! counts left-fruit))
      (set! left (+ left 1)))

    (set! max-len (max max-len (+ (- right left) 1))))

  max-len)

(define-syntax (pure-return stx)
  (syntax-case stx ()
    [(_ val) #'(begin (void) val)])) ; A simple way to provide a "return" like behavior without using call/cc