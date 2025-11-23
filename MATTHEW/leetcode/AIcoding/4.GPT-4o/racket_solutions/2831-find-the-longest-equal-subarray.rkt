(define (findLongestEqualSubarray nums)
  (define n (length nums))
  (define max-length 0)
  (define current-length 1)

  (for ([i (in-range 1 n)])
    (if (= (list-ref nums i) (list-ref nums (- i 1)))
        (begin
          (set! current-length (+ current-length 1)))
        (begin
          (set! max-length (max max-length current-length))
          (set! current-length 1))))

  (set! max-length (max max-length current-length))
  max-length)