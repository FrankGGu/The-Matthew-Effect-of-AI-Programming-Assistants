(define (number-of-subarrays-with-and-value-of-k nums k)
  (let ([total-ans 0]
        [current-and-counts (make-hash)]) ; hash mapping AND value to count
    (for ([num (in-list nums)])
      (let ([next-and-counts (make-hash)])
        ; Process subarrays ending at previous index
        (hash-for-each
         (lambda (and-val count)
           (let ([new-and-val (bitwise-and and-val num)])
             (hash-set! next-and-counts new-and-val
                        (+ count (hash-ref next-and-counts new-and-val 0)))))
         current-and-counts)

        ; Process subarray consisting of just the current number
        (hash-set! next-and-counts num
                   (+ 1 (hash-ref next-and-counts num 0)))

        ; Add to total-ans if k is found in next-and-counts
        (when (hash-has-key? next-and-counts k)
          (set! total-ans (+ total-ans (hash-ref next-and-counts k))))

        ; Update current-and-counts for the next iteration
        (set! current-and-counts next-and-counts)))
    total-ans))