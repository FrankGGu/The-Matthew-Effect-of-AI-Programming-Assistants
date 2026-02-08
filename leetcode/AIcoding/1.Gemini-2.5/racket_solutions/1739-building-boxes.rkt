#lang racket

(define (building-boxes n)
  ;; Function to calculate total boxes in a complete triangular pyramid of height k.
  ;; The formula is sum_{i=1 to k} (i * (i + 1) / 2) = k * (k + 1) * (k + 2) / 6.
  (define (total-pyramid-boxes k)
    (if (zero? k)
        0
        (/ (* k (+ k 1) (+ k 2)) 6)))

  ;; Function to calculate boxes on the floor for a complete triangular pyramid of height k.
  ;; The formula is 1 + 2 + ... + k = k * (k + 1) / 2.
  (define (floor-boxes-pyramid k)
    (if (zero? k)
        0
        (/ (* k (+ k 1)) 2)))

  ;; Step 1: Find the smallest k_max_height such that a complete pyramid of this height
  ;; contains at least n boxes.
  (let loop-k ((k 1))
    (let ((current-total-boxes (total-pyramid-boxes k)))
      (if (>= current-total-boxes n)
          ;; k is the smallest height for a full pyramid that can hold n boxes.
          ;; This k is our k_max_height.
          (let* ((k-max-height k)
                 ;; Calculate total boxes in a pyramid of height (k-max-height - 1).
                 (boxes-in-pyramid-k-minus-1 (total-pyramid-boxes (- k-max-height 1)))
                 ;; Calculate the number of boxes remaining to be placed after forming
                 ;; a complete pyramid of height (k-max-height - 1).
                 (remaining-n (- n boxes-in-pyramid-k-minus-1))
                 ;; Calculate the number of boxes on the floor for a pyramid of height (k-max-height - 1).
                 (floor-boxes-k-minus-1 (floor-boxes-pyramid (- k-max-height 1))))

            ;; Step 2: Place the `remaining-n` boxes.
            ;; These boxes will be added to the k-max-height-th layer.
            ;; They are placed greedily, starting from the corner, extending the base.
            ;; We need to find 'm', the number of new "rows" added to the floor.
            ;; 'm' is the smallest integer such that 1 + 2 + ... + m >= remaining-n.
            (let loop-m ((m 1))
              (let ((boxes-in-m-rows (floor-boxes-pyramid m))) ; This is 1+2+...+m
                (if (>= boxes-in-m-rows remaining-n)
                    ;; 'm' is the number of additional floor boxes needed.
                    ;; Total floor boxes = floor boxes from k-1 pyramid + 'm' additional floor boxes.
                    (+ floor-boxes-k-minus-1 m)
                    (loop-m (+ m 1))))))
          ;; If current-total-boxes is less than n, try a taller pyramid.
          (loop-k (+ k 1))))))