(define (max-square-area h-fences v-fences)
  (define (get-intervals fences max-len)
    (let loop ([prev 0] [fences (sort fences <)] [intervals '()])
      (if (null? fences)
          (cons (- max-len prev) intervals)
          (let ([curr (car fences)])
            (loop curr (cdr fences) (cons (- curr prev) intervals))))))

  (define h-intervals (get-intervals h-fences 1000000000))
  (define v-intervals (get-intervals v-fences 1000000000))

  (define h-sorted (sort h-intervals >))
  (define v-sorted (sort v-intervals >))

  (let loop ([i 0] [j 0] [max-area 0])
    (if (or (>= i (length h-sorted)) (>= j (length v-sorted)))
        max-area
        (let ([h (list-ref h-sorted i)] [v (list-ref v-sorted j)])
          (cond
            [(= h v) (* h v)]
            [(> h v) (loop (add1 i) j max-area)]
            [else (loop i (add1 j) max-area)])))))