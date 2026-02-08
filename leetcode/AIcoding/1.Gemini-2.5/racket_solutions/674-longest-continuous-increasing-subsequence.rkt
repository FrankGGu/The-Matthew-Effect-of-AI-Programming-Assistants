(define (find-length-of-lcis nums)
  (if (empty? nums)
      0
      (let loop ((lst (cdr nums))
                 (prev (car nums))
                 (current-len 1)
                 (max-len 1))
        (if (empty? lst)
            max-len
            (let* ((curr (car lst))
                   (new-current-len (if (> curr prev) (+ current-len 1) 1))
                   (new-max-len (max max-len new-current-len)))
              (loop (cdr lst) curr new-current-len new-max-len))))))