(define (find-integers n)
  (if (= n 0)
      1
      (let* ([L (integer-length n)] ; Number of bits in n
             [fib (make-vector (+ L 1) 0)]) ; fib[i] = count of valid binary strings of length i

        ; Initialize fib array
        ; fib[0] = 1 (empty string, or effectively the number 0)
        ; fib[1] = 2 (0, 1)
        ; fib[i] = fib[i-1] + fib[i-2] for i > 1
        (vector-set! fib 0 1)
        (when (> L 0)
          (vector-set! fib 1 2))
        (for ([i (in-range 2 (+ L 1))])
          (vector-set! fib i (+ (vector-ref fib (- i 1)) (vector-ref fib (- i 2)))))

        ; Recursive helper function to count valid integers
        ; i: current bit position, from MSB down to 0
        ; current-total-count: accumulated count of valid integers strictly less than n
        ; last-bit-of-n-was-one?: #t if the previous bit of n was 1, #f otherwise
        (let fib-loop ([i (- L 1)]
                       [current-total-count 0]
                       [last-bit-of-n-was-one? #f])
          (if (< i 0)
              ; If we've processed all bits of n, and no '11' sequence was found in n,
              ; it means n itself is a valid number. So add 1 to the total count.
              (+ current-total-count 1)
              (let* ([current-bit-of-n (if (logbit? i n) 1 0)])
                (if (= current-bit-of-n 1)
                    (if last-bit-of-n-was-one?
                        ; Case 1: Current bit of n is 1, and previous bit of n was 1.
                        ; This means n contains "11", so n itself is invalid.
                        ; We have already counted all valid numbers strictly less than n.
                        ; No further numbers can be formed by changing bits to the right
                        ; of this "11" prefix in n.
                        current-total-count
                        ; Case 2: Current bit of n is 1, and previous bit of n was 0.
                        ; We can form valid numbers by placing a '0' at this position.
                        ; These numbers will be smaller than n. Add fib[i] to count.
                        ; Then, continue processing the remaining bits of n,
                        ; remembering that the current bit of n was 1.
                        (fib-loop (- i 1)
                                  (+ current-total-count (vector-ref fib i))
                                  #t))
                    ; Case 3: Current bit of n is 0.
                    ; We cannot place a '1' at this position to form a number smaller than n
                    ; that starts with the same prefix as n, because n has a '0' here.
                    ; So, just continue processing the remaining bits of n,
                    ; remembering that the current bit of n was 0.
                    (fib-loop (- i 1)
                              current-total-count
                              #f))))))))