(define/contract (has-alternating-bits n)
  (-> exact-integer? boolean?)
  (let loop ((prev-bit (bitwise-and n 1))
             (num (arithmetic-shift n -1)))
    (if (zero? num)
        #t
        (let ((curr-bit (bitwise-and num 1)))
          (if (= curr-bit prev-bit)
              #f
              (loop curr-bit (arithmetic-shift num -1)))))))