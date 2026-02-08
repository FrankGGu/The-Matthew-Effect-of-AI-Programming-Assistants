(define Bitset
  (class object%
    (init size)
    (super-new)
    (define size size)
    (define bits (make-vector size #f))
    (define count 0)

    (define/public (fix bit)
      (if (vector-ref bits bit)
          (begin
            (vector-set! bits bit #f)
            (set! count (- count 1)))
          (begin
            (vector-set! bits bit #t)
            (set! count (+ count 1)))))

    (define/public (all?)
      (= count size))

    (define/public (one?)
      (> count 0))

    (define/public (count)
      count)

    (define/public (to-string)
      (let loop ((i 0) (result ""))
        (if (= i size)
            result
            (loop (+ i 1) (string-append result (if (vector-ref bits i) "1" "0"))))))

    (define/public (flip bit)
      (if (vector-ref bits bit)
          (begin
            (vector-set! bits bit #f)
            (set! count (- count 1)))
          (begin
            (vector-set! bits bit #t)
            (set! count (+ count 1)))))

    (define/public (flip-all)
      (set! count (- size count))
      (for ((i (in-range size)))
        (vector-set! bits i (not (vector-ref bits i)))))))