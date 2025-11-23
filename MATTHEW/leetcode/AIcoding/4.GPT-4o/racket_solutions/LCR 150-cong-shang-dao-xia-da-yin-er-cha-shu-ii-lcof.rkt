(define (minLightsNeeded houses)
  (define (range-coverage pos)
    (if (zero? pos)
        1
        (+ 1 (if (>= pos 2) 2 1))))

  (define (count-lights houses)
    (let loop ((pos 0) (count 0))
      (if (>= pos (length houses))
          count
          (if (equal? (list-ref houses pos) 0)
              (loop (+ pos 1) count)
              (begin
                (set! count (+ count 1))
                (loop (+ pos (range-coverage pos)) count))))))

  (count-lights houses))

(minLightsNeeded '(0 1 0 0 1 0 0 1))