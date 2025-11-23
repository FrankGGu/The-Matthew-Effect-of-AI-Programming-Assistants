(provide bitset% new-bitset)

(define bitset%
  (class object%
    (init size)
    (super-new)
    (define bits (make-vector size #f))
    (define count 0)
    (define size size)

    (define/public (fix index)
      (unless (vector-ref bits index)
        (vector-set! bits index #t)
        (set! count (+ count 1))))

    (define/public (unfix index)
      (when (vector-ref bits index)
        (vector-set! bits index #f)
        (set! count (- count 1))))

    (define/public (flip)
      (for ([i (in-range size)])
        (if (vector-ref bits i)
            (begin (vector-set! bits i #f))
            (begin (vector-set! bits i #t))))
      (set! count (- size count)))

    (define/public (all)
      (= count size))

    (define/public (one)
      (> count 0))

    (define/public (count)
      count)

    (define/public (to-string)
      (list->string (map (lambda (x) (if x #\1 #\0)) (vector->list bits))))
    ))

(define (new-bitset size)
  (new bitset% [size size]))