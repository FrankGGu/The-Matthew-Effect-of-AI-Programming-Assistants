(define (min-operations nums)
  (let loop ((idx 0)
             (current-carry 0)
             (total-operations 0))
    (if (>= idx (length nums))
        total-operations
        (let* ((num-at-idx (list-ref nums idx))
               (needed (+ num-at-idx current-carry)))
          (loop (+ idx 1)
                needed
                (+ total-operations needed))))))