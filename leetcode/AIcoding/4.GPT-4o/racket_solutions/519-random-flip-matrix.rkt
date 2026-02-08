(define rand-flip-matrix
  (lambda (nRows nCols)
    (define grid (make-vector nRows (make-vector nCols #f)))
    (define rand-positions (make-hash))
    (define total-cells (* nRows nCols))
    (define count 0)

    (define (pick-random)
      (if (= count total-cells)
          (error "All cells have been flipped")
          (let* ((random-index (random (- total-cells count)))
                 (position (hash-ref rand-positions random-index #f)))
            (if position
                (begin
                  (hash-set! rand-positions random-index (hash-ref rand-positions (- (hash-count rand-positions) 1)))
                  (hash-set! rand-positions (- (hash-count rand-positions) 1) position)
                  (set! count (+ count 1))
                  position)
                (begin
                  (set! count (+ count 1))
                  (let* ((row (quotient random-index nCols))
                         (col (remainder random-index nCols)))
                    (vector-set! (vector-ref grid row) col #t)
                    (list row col)))))))

    (define (flip)
      (pick-random))

    (define (reset)
      (set! count 0)
      (for ([i nRows])
        (for ([j nCols])
          (vector-set! (vector-ref grid i) j #f)))
      (set! rand-positions (make-hash)))

    (list flip reset)))