(define (longest-subarray nums)
  (if (empty? nums)
      0
      (let loop ((current-list (rest nums))
                 (prev-val (first nums))
                 (max-len 1)
                 (inc-len 1)
                 (dec-len 1))
        (if (empty? current-list)
            max-len
            (let ((current-val (first current-list)))
              (cond
                ((> current-val prev-val)
                 (loop (rest current-list)
                       current-val
                       (max max-len (+ inc-len 1))
                       (+ inc-len 1)
                       1))
                ((< current-val prev-val)
                 (loop (rest current-list)
                       current-val
                       (max max-len (+ dec-len 1))
                       1
                       (+ dec-len 1)))
                (else ; (= current-val prev-val)
                 (loop (rest current-list)
                       current-val
                       (max max-len 1)
                       1
                       1)))))))