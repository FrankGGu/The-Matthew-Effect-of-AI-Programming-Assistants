(define (count-peaks nums)
  (let ((n (length nums)))
    (if (< n 3)
        0
        (let loop ((current-list (cdr nums))
                   (prev (car nums))
                   (count 0))
          (if (null? (cdr current-list))
              count
              (let* ((curr (car current-list))
                     (next (car (cdr current-list))))
                (if (and (> curr prev) (> curr next))
                    (loop (cdr current-list) curr (+ count 1))
                    (loop (cdr current-list) curr count))))))))