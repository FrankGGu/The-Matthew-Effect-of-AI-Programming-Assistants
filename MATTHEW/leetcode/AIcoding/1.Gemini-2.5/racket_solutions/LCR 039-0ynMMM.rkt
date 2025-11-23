(define (largest-rectangle-area heights)
  (define h-vec (list->vector heights))
  (define n (vector-length h-vec))
  (define max-area 0)
  (define st '()) ; stack to store indices

  (for ([i (in-range (add1 n))])
    (define current-height
      (if (< i n)
          (vector-ref h-vec i)
          0))

    (let loop ()
      (when (and (not (empty? st))
                 (< current-height (vector-ref h-vec (car st))))
        (define h-idx (car st))
        (set! st (cdr st))
        (define h (vector-ref h-vec h-idx))
        (define width
          (if (empty? st)
              i
              (- i (add1 (car st)))))
        (set! max-area (max max-area (* h width)))
        (loop)))

    (set! st (cons i st)))

  max-area)