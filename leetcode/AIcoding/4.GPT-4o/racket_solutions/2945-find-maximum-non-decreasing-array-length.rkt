(define (longest-non-decreasing-array nums)
  (define max-len 0)
  (define current-len 1)
  (define n (length nums))

  (if (zero? n) 
      0
      (for ([i (in-range 1 n)])
        (if (<= (list-ref nums (- i 1)) (list-ref nums i))
            (set! current-len (+ current-len 1))
            (begin
              (set! max-len (max max-len current-len))
              (set! current-len 1))))
      (set! max-len (max max-len current-len)))
  max-len)