(define (min-changes s)
  (let loop ((i 0) (count1 0) (count2 0))
    (if (= i (string-length s))
        (min count1 count2)
        (let ((expected1 (if (even? i) #\0 #\1))
              (expected2 (if (even? i) #\1 #\0)))
          (loop (+ i 1)
                (if (= (string-ref s i) expected1) count1 (+ count1 1))
                (if (= (string-ref s i) expected2) count2 (+ count2 1)))))))

(min-changes "0100") ; Example usage