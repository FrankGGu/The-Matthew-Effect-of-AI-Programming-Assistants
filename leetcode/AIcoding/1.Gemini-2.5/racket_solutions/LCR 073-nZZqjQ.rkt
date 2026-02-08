(define (min-eating-speed piles h)
  ;; Helper function to check if Koko can eat all bananas with speed k within h hours.
  (define (can-finish? k)
    (let ((total-hours (for/sum ((p piles))
                         ;; Calculate hours for each pile: (p + k - 1) / k using integer division
                         ;; or (ceiling (/ p k)) using floating point and then ceiling.
                         ;; Racket's ceiling works with numbers.
                         (ceiling (/ p k)))))
      (<= total-hours h)))

  ;; Determine the search range for k.
  ;; The minimum possible speed is 1 (Koko eats 1 banana per hour).
  ;; The maximum possible speed is the size of the largest pile (Koko eats the largest pile in 1 hour).
  (let* ((max-pile (if (null? piles) 1 (apply max piles)))
         (low 1)
         (high max-pile)
         (ans max-pile)) ; Initialize 'ans' with an upper bound.

    ;; Binary search loop to find the minimum k.
    (let loop ((l low) (r high) (current-ans ans))
      (if (> l r)
          current-ans
          (let* ((mid (+ l (floor (/ (- r l) 2)))))
            (if (can-finish? mid)
                ;; If Koko can finish with speed 'mid', 'mid' is a potential answer.
                ;; Try to find an even smaller speed in the left half [l, mid-1].
                (loop l (- mid 1) mid)
                ;; If Koko cannot finish with speed 'mid', then 'mid' is too slow.
                ;; Increase the speed, search in the right half [mid+1, r].
                (loop (+ mid 1) r current-ans)))))))