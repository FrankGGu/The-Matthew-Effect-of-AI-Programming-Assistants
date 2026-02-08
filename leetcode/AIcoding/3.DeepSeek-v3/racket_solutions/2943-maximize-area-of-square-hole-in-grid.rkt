(define (maximize-square-hole n m h-bars v-bars)
  (define (max-consecutive nums)
    (let loop ((nums (sort nums <))
               (current 1)
               (max-len 1))
      (if (null? nums)
          max-len
          (let ((next (if (or (null? (cdr nums)) (not (= (car nums) (- (cadr nums) 1))))
                       1
                       (+ current 1))))
          (loop (cdr nums)
                next
                (max max-len next)))))

  (let ((h-max (max-consecutive h-bars))
        (v-max (max-consecutive v-bars)))
    (let ((side (min h-max v-max)))
      (* side side)))