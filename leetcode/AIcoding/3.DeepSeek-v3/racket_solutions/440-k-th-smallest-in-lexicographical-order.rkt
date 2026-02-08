(define (findKthNumber n k)
  (let loop ((curr 1) (k (- k 1)))
    (if (zero? k)
        curr
        (let ((steps 0) (first curr) (last (+ curr 1))))
          (let count-steps ()
            (if (> first n)
                (begin
                  (set! steps (- steps 1))
                  (loop (+ curr 1) (- k steps)))
                (begin
                  (set! steps (+ steps (- (min last (+ n 1)) first))
                  (set! first (* first 10))
                  (set! last (* last 10))
                  (count-steps))))))))