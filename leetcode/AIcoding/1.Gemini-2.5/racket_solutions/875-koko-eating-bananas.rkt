(define (min-eating-speed piles h)
  ;; Helper function to check if a given speed 'k' is sufficient
  (define (can-finish? k)
    (let loop ((remaining-piles piles) (hours-needed 0))
      (cond
        ((null? remaining-piles)
         (<= hours-needed h))
        (else
         (let* ((pile (car remaining-piles))
                (time-for-pile (ceiling (/ pile k))))
           ;; If hours-needed already exceeds h, short-circuit
           (if (> (+ hours-needed time-for-pile) h)
               #f
               (loop (cdr remaining-piles) (+ hours-needed time-for-pile))))))))

  ;; Binary search for the minimum 'k'
  (let* ((low 1)
         (high (apply max piles)) ; Max possible speed is the largest pile size
         (ans high)) ; Initialize answer with a valid but possibly not optimal speed

    (let loop ((l low) (r high) (current-ans ans))
      (cond
        ((> l r)
         current-ans)
        (else
         (let* ((mid (quotient (+ l r) 2)))
           (if (can-finish? mid)
               ;; If 'mid' speed works, it's a potential answer. Try smaller speeds.
               (loop l (- mid 1) mid)
               ;; If 'mid' speed doesn't work, need faster speed.
               (loop (+ mid 1) r current-ans))))))))