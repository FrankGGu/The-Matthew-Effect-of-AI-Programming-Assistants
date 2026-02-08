(define (can-reorder-doubled arr)
  (define counts (make-hash))
  (for-each (lambda (n)
              (hash-set! counts n (+ (hash-ref counts n 0) 1)))
            arr)

  (define sorted-arr
    (sort arr
          (lambda (a b)
            (< (abs a) (abs b)))))

  (block 'check-pairs
    (for ([x sorted-arr])
      (define count-x (hash-ref counts x 0))
      (when (> count-x 0)
        (hash-set! counts x (- count-x 1))

        (define y (* 2 x))
        (define count-y (hash-ref counts y 0))

        (when (= count-y 0)
          (break 'check-pairs #f))

        (hash-set! counts y (- count-y 1))))
    #t))