#lang racket

(define (longest-subarray nums)
  (let ([max-len 0]
        [prev-ones 0]
        [current-ones 0]
        [has-zero #f])
    (for ([num (in-list nums)])
      (if (= num 1)
          (set! current-ones (+ current-ones 1))
          (begin
            (set! has-zero #t)
            (set! max-len (max max-len (+ prev-ones current-ones)))
            (set! prev-ones current-ones)
            (set! current-ones 0))))

    (set! max-len (max max-len (+ prev-ones current-ones)))

    (if (not has-zero)
        (- (length nums) 1)
        max-len)))