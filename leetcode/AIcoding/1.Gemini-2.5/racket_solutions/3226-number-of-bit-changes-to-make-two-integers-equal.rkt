(define (min-bit-changes n k)
  (if (not (= (bitwise-and n k) k))
      -1
      (let ((diff (bitwise-xor n k)))
        (let loop ((num diff) (count 0))
          (if (zero? num)
              count
              (loop (bitwise-and num (sub1 num)) (add1 count)))))))