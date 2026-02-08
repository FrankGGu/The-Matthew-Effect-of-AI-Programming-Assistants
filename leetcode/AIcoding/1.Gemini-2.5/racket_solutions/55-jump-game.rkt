(define (can-jump nums)
  (define n (length nums))

  (let loop ((idx 0) (max-reach 0) (current-nums nums))
    (cond
      ;; If the furthest we can reach is at or beyond the last index, we can jump to the end.
      ((>= max-reach (- n 1)) #t)

      ;; If we have processed all numbers but haven't reached the end, then we cannot.
      ((null? current-nums) #f)

      ;; If the current index is beyond the furthest we could possibly reach,
      ;; it means there's a gap we cannot cross.
      ((> idx max-reach) #f)

      ;; Otherwise, update the maximum reach and continue to the next position.
      (else
       (loop (+ idx 1)
             (max max-reach (+ idx (car current-nums)))
             (cdr current-nums))))))