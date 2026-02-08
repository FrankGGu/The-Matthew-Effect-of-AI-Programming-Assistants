#lang racket

(define (wiggle-sort! nums)
  (let* ((n (vector-length nums))
         (s (list->vector (sort (vector->list nums) <))) ; Create a sorted copy
         (mid-idx (quotient (- n 1) 2)) ; Integer division for floor((n-1)/2)
         (p1 mid-idx)
         (p2 (- n 1)))
    (for ((i (in-range n)))
      (if (even? i)
          (begin
            (vector-set! nums i (vector-ref s p1))
            (set! p1 (- p1 1)))
          (begin
            (vector-set! nums i (vector-ref s p2))
            (set! p2 (- p2 1)))))))