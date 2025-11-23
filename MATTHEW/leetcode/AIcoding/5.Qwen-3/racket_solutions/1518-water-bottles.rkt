(define (num-water-bottles num-bottles num-empty)
  (let loop ((full num-bottles) (empty 0) (total 0))
    (if (< full 1)
        total
        (loop (- full 1) (+ empty 1) (+ total 1)))))