(define (num-music-pairs nums)
  (define (helper nums count)
    (if (null? nums)
        count
        (let* ((num (car nums))
               (remainder (modulo num 60))
               (complement (if (= remainder 0) 0 (- 60 remainder))))
          (helper (cdr nums) (+ count (if (member complement (cdr nums)) 1 0)))))))
  (helper nums 0))

(define (main nums)
  (num-music-pairs nums))