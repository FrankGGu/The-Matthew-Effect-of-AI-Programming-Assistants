(define (check-if-array-is-sorted-and-rotated nums)
  (let* ((n (length nums))
         (arr (list->vector nums))) ; Convert list to vector for O(1) access
    (if (< n 2)
        #t ; If length is 0 or 1, it's always sorted and rotated.
        (let loop ((i 0) (breaks 0))
          (if (= i n)
              (<= breaks 1)
              (loop (+ i 1)
                    (if (> (vector-ref arr i) (vector-ref arr (modulo (+ i 1) n)))
                        (+ breaks 1)
                        breaks)))))))