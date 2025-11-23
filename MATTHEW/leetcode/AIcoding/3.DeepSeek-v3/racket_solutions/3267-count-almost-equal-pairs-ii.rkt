(define (count-almost-equal-pairs nums)
  (let loop ((i 0) (count 0))
    (if (>= i (length nums))
        count
        (let inner-loop ((j (+ i 1)) (count count))
          (if (>= j (length nums))
              (loop (+ i 1) count)
              (let ((diff (abs (- (list-ref nums i) (list-ref nums j)))))
                (inner-loop (+ j 1) (if (<= diff 1) (+ count 1) count)))))))