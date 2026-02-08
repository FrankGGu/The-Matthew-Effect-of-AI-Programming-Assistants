(define (k-increasing arr k)
  (let* ([n (vector-length arr)]
         [total-operations 0])

    ; Helper function to find the length of the longest non-decreasing subsequence
    ; Takes a list of numbers `nums`
    (define (length-of-longest-non-decreasing-subsequence nums)
      (if (null? nums)
          0
          (let* ([max-len (length nums)]
                 ; Pre-allocate tails vector to maximum possible length
                 ; and track its effective length.
                 ; This avoids vector-append! which might not be standard in LeetCode's Racket.
                 ; Initialize with 0, which is smaller than any possible arr[i] (1 to 10^9).
                 [tails (make-vector max-len 0)]
                 [current-tails-len 0])

            ; Binary search to find the index of the first element in `tails`
            ; that is greater than or equal to `target`.
            ; This is equivalent to `lower_bound` in C++.
            ; Returns -1 if no such element is found (meaning `target` is greater
            ; than all elements in `tails`).
            (define (binary-search-for-replacement target)
              (let loop ([low 0] [high (- current-tails-len 1)] [ans -1])
                (if (> low high)
                    ans
                    (let ([mid (+ low (quotient (- high low) 2))])
                      (if (>= (vector-ref tails mid) target)
                          (loop low (- mid 1) mid) ; Found a candidate, try to find an even smaller one to the left
                          (loop (+ mid 1) high ans)))))) ; `target` is larger, must look to the right

            (for-each (lambda (num)
                        (let ([idx (binary-search-for-replacement num)])
                          (if (= idx -1) ; `num` is greater than all elements in `tails`
                              (begin
                                (vector-set! tails current-tails-len num) ; Append `num` to the end of effective tails
                                (set! current-tails-len (+ current-tails-len 1)))
                              (vector-set! tails idx num)))) ; Replace element at `idx` with `num`
                      nums)
            current-tails-len)))) ; The effective length of `tails` is the LNDS length

    ; Iterate through k starting positions to form k subsequences
    (for ([i (in-range k)])
      (let* ([current-subsequence-list '()] ; Build subsequence as a list
             [subsequence-length 0])
        ; Collect elements for the current k-subsequence
        ; j starts at i, goes up to n, stepping by k
        (for ([j (in-range i n k)])
          (set! current-subsequence-list (cons (vector-ref arr j) current-subsequence-list))
          (set! subsequence-length (+ subsequence-length 1)))

        ; The list was built in reverse order, reverse it back to original order
        (set! current-subsequence-list (reverse current-subsequence-list))

        ; Calculate LNDS length for this subsequence
        (let ([lnds-len (length-of-longest-non-decreasing-subsequence current-subsequence-list)])
          ; Add operations needed for this subsequence to the total
          ; Operations = (length of subsequence) - (length of LNDS)
          (set! total-operations (+ total-operations (- subsequence-length lnds-len))))))

    total-operations))