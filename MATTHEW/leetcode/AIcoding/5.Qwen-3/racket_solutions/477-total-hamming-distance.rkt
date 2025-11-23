(define (total-hamming-distance nums)
  (define (count-set-bits n)
    (let loop ((n n) (count 0))
      (if (= n 0)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))

  (define (hamming-distance a b)
    (count-set-bits (bitwise-xor a b)))

  (define len (length nums))
  (let loop ((i 0) (total 0))
    (if (= i len)
        total
        (let ((num (list-ref nums i)))
          (loop (+ i 1) (+ total (foldl (lambda (x acc) (+ acc (hamming-distance num x))) 0 (list-tail nums i))))))))