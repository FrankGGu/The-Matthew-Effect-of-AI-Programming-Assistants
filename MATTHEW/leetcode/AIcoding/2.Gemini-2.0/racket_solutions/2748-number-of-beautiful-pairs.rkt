(define (first-digit n)
  (if (< n 10)
      n
      (first-digit (quotient n 10))))

(define (count-beautiful-pairs nums)
  (let ((len (length nums)))
    (let loop ((i 0) (count 0))
      (if (= i len)
          count
          (let loop2 ((j (add1 i)))
            (if (= j len)
                (loop (add1 i) count)
                (let ((first-i (first-digit (list-ref nums i)))
                      (last-j (modulo (list-ref nums j) 10)))
                  (if (= (gcd first-i last-j) 1)
                      (loop2 (add1 j) (add1 count))
                      (loop2 (add1 j) count)))))))))