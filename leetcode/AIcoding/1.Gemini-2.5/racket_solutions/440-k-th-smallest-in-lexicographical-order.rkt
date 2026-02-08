(define (find-kth-number n k)

  (define (count-steps n prefix)
    (let loop ((current prefix)
               (next-prefix (+ prefix 1))
               (steps 0))
      (if (> current n)
          steps
          (loop (* current 10)
                (* next-prefix 10)
                (+ steps (- (min n (- next-prefix 1)) current -1))))))

  (let loop ((current 1)
             (k-remaining (- k 1)))
    (if (= k-remaining 0)
        current
        (let ((c (count-steps n current)))
          (if (>= k-remaining c)
              (loop (+ current 1) (- k-remaining c))
              (loop (* current 10) (- k-remaining 1)))))))