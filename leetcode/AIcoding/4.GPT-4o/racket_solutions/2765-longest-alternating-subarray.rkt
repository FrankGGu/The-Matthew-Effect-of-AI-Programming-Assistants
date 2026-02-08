(define (findLengthA(nums))
  (define (longest-alternating-subarray nums)
    (define max-length 0)
    (define current-length 1)
    (for ([i (in-range 1 (length nums))])
      (if (not (= (modulo (list-ref nums (- i 1)) 2) (modulo (list-ref nums i) 2)))
          (begin
            (set! current-length (+ current-length 1))
            (set! max-length (max max-length current-length)))
          (set! current-length 1)))
    max-length)

  (longest-alternating-subarray nums))

(findLengthA '(1 0 1 0 1))