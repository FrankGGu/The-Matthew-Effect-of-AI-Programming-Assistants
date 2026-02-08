(define (jump-game-ii nums-list)
  (define nums (list->vector nums-list))
  (define n (vector-length nums))

  (if (<= n 1)
      0
      (let loop ((i 0)
                 (jumps 0)
                 (current-jump-end 0)
                 (farthest-reach 0))
        (if (= i (- n 1))
            jumps
            (let* ((num-at-i (vector-ref nums i))
                   (new-farthest-reach (max farthest-reach (+ i num-at-i))))
              (if (= i current-jump-end)
                  (loop (+ i 1)
                        (+ jumps 1)
                        new-farthest-reach
                        new-farthest-reach)
                  (loop (+ i 1)
                        jumps
                        current-jump-end
                        new-farthest-reach)))))))