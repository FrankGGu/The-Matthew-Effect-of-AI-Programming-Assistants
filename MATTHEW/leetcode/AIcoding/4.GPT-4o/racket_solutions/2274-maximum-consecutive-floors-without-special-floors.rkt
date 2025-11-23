(define (max-consecutive-floors n stairs)
  (let loop ((i 0) (count 0) (max-count 0))
    (cond
      [(= i n) max-count]
      [(member i stairs) (loop (+ i 1) 0 max-count)]
      [else (loop (+ i 1) (+ count 1) (max max-count (+ count 1)))])))

(define (maximumConsecutiveFloors stairs n)
  (max-consecutive-floors n stairs))