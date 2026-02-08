(define (minimum-number-game nums)
  (let* ((sorted-nums (sort nums <))
         (paired-and-swapped
          (for/list ((i (in-range 0 (length sorted-nums) 2)))
            (list (list-ref sorted-nums (+ i 1))
                  (list-ref sorted-nums i)))))
    (apply append paired-and-swapped)))