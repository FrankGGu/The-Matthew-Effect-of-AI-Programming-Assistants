(define (pivot-index nums)
  (let ((total (apply + nums)))
    (let loop ((i 0) (left 0))
      (if (>= i (length nums))
          -1
          (let ((right (- total left (list-ref nums i))))
            (if (= left right)
                i
                (loop (+ i 1) (+ left (list-ref nums i)))))))))