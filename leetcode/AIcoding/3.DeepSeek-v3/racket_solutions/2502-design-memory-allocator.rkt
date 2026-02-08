(define-struct allocator (memory blocks))

(define (make-allocator n)
  (make-allocator (make-vector n -1) '()))

(define (allocator-allocate a size mID)
  (let ([memory (allocator-memory a)]
        [blocks (allocator-blocks a)]
        [n (vector-length (allocator-memory a))])
    (let loop ([i 0])
      (cond
        [(> (+ i size) n) -1]
        [(andmap (lambda (j) (= (vector-ref memory j) -1)) (range i (+ i size)))]
          (for ([j (in-range i (+ i size))])
            (vector-set! memory j mID))
          (set-allocator-blocks! a (cons (list mID i size) blocks))
          i]
        [else (loop (+ i 1))]))))

(define (allocator-free a mID)
  (let ([memory (allocator-memory a)]
        [blocks (allocator-blocks a)]
        [count 0])
    (for ([block (in-list blocks)])
      (when (= (first block) mID)
        (let ([start (second block)]
              [size (third block)])
          (for ([i (in-range start (+ start size))])
            (vector-set! memory i -1))
          (set! count (+ count size))))
    (set-allocator-blocks! a (filter (lambda (block) (not (= (first block) mID))) blocks))
    count))

(define (allocator-clear a)
  (let ([memory (allocator-memory a)])
    (for ([i (in-range (vector-length memory))])
      (vector-set! memory i -1))
    (set-allocator-blocks! a '())))