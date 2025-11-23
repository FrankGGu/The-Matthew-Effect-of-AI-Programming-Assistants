#lang racket

(define (tallest-billboard rods)
  (let ((dp (hash 0 0))) ; Map diff -> max_left_sum, initialized with (0 -> 0)

    (for-each (lambda (rod)
                (let ((new-dp (hash)))
                  (hash-for-each dp
                                 (lambda (diff left-sum)
                                   ; Option 1: Don't use the rod
                                   ; The current (diff, left-sum) state from dp is carried over to new-dp
                                   (hash-set! new-dp diff (max (hash-ref new-dp diff -1) left-sum))

                                   ; Option 2: Add rod to left billboard
                                   (let* ((new-diff (+ diff rod))
                                          (new-left-sum (+ left-sum rod)))
                                     (hash-set! new-dp new-diff (max (hash-ref new-dp new-diff -1) new-left-sum)))

                                   ; Option 3: Add rod to right billboard
                                   (let* ((new-diff (- diff rod))
                                          (new-left-sum left-sum)) ; left_sum doesn't change
                                     (hash-set! new-dp new-diff (max (hash-ref new-dp new-diff -1) new-left-sum))))
                  (set! dp new-dp)))
              rods)

    ; The result is the maximum left_sum when the difference is 0.
    ; If no such state exists, hash-ref returns -1. We take max with 0 to handle this.
    (max 0 (hash-ref dp 0 -1))))