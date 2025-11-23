#lang racket

(define (find-median-of-uniqueness-array nums)
  (define n (vector-length nums))

  (define (count-le-x x)
    (define count 0)
    (define left 0)
    (define freq (make-hash))
    (define current-uniques 0)

    (for ([right (in-range n)])
      (define num-r (vector-ref nums right))
      (hash-update! freq num-r add1 0)
      (when (= (hash-ref freq num-r) 1)
        (set! current-uniques (add1 current-uniques)))

      (while (> current-uniques x)
        (define num-l (vector-ref nums left))
        (hash-update! freq num-l sub1)
        (when (= (hash-ref freq num-l) 0)
          (set! current-uniques (sub1 current-uniques)))
        (set! left (add1 left)))

      (set! count (+ count (- right left -1)))) ; Equivalent to (+ count (right - left + 1))

    count)

  (define total-subarrays (/ (* n (+ n 1)) 2))
  (define median-rank (ceiling (/ total-subarrays 2)))

  (define low 1)
  (define high n)
  (define ans n)

  (while (<= low high)
    (define mid (+ low (quotient (- high low) 2)))
    (if (>= (count-le-x mid) median-rank)
        (begin
          (set! ans mid)
          (set! high (- mid 1)))
        (set! low (+ mid 1))))
  ans)