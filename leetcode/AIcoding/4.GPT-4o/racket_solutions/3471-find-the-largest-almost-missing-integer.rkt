(define (find-largest-almost-missing-integer nums)
  (let ((num-set (set nums)))
    (for/fold ([max-num -1]) ([i (in-range 0 (add1 (length nums)))])
      (if (not (set-member? num-set i))
          (max max-num i)
          max-num))))

(find-largest-almost-missing-integer '(0 1 2 3 4))