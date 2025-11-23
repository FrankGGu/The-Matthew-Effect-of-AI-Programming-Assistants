(define (can-reach destination fuel)
  (define (dfs pos fuel)
    (if (>= pos destination) #t
        (if (<= fuel 0) #f
            (or (dfs (+ pos 1) (- fuel 1))
                (dfs (+ pos 2) (- fuel 1))))))
  (dfs 0 fuel))

(define (can-reach destination fuel)
  (dfs 0 fuel))

(define (dfs pos fuel)
  (if (>= pos destination) #t
      (if (<= fuel 0) #f
          (or (dfs (+ pos 1) (- fuel 1))
              (dfs (+ pos 2) (- fuel 1))))))