(define (min-increments-for-target-multiples nums target)
  (let loop ((nums-list nums)
             (current-min-val 0)
             (total-increments 0))
    (if (empty? nums-list)
        total-increments
        (let* ((num (car nums-list))
               (effective-min-val (max num current-min-val))
               (next-multiple-val
                 (let ((rem (modulo effective-min-val target)))
                   (if (= rem 0)
                       effective-min-val
                       (+ effective-min-val (- target rem)))))
               (increment (- next-multiple-val num)))
          (loop (cdr nums-list)
                next-multiple-val
                (+ total-increments increment))))))