(define (num-subarrays-with-sum nums goal)
  (define (at-most-k-sum nums k)
    (if (< k 0)
        0
        (let loop ([left 0] [right 0] [sum 0] [count 0])
          (if (>= right (length nums))
              count
              (let ([new-sum (+ sum (list-ref nums right))])
                (if (> new-sum k)
                    (loop (+ left 1) right (- new-sum (list-ref nums left)) count)
                    (loop left (+ right 1) new-sum (+ count (+ right 1 (- left))))))))))

  (- (at-most-k-sum nums goal) (at-most-k-sum nums (- goal 1))))