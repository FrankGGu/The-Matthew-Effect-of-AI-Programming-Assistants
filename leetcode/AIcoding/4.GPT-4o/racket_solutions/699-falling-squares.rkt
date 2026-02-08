(define (falling-squares positions)
  (define results '())
  (define max-height 0)
  (define heights (make-vector 10001 0))

  (for ([pos positions])
    (define (start) (car pos))
    (define (size) (cadr pos))
    (define (end) (+ (start) (size)))

    (define (curr-height)
      (apply max (for/list ([i (range (start) (end))])
                   (vector-ref heights i))))

    (define h (curr-height))
    (set! max-height (max max-height (+ h (if (= h 0) 0 1))))

    (for ([i (range (start) (end))])
      (vector-set! heights i (+ (vector-ref heights i) (if (= h 0) 1 0))))

    (set! results (append results (list max-height))))

  results)

(falling-squares '((1 2) (2 3) (6 1)))