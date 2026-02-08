(define (count-distinct-integers nums)
  (define (reverse-int n)
    (let loop ([n n] [acc 0])
      (if (zero? n)
          acc
          (loop (quotient n 10) (+ (* acc 10) (remainder n 10))))))

  (define reversed-nums (map reverse-int nums))
  (define all-nums (append nums reversed-nums))
  (length (remove-duplicates all-nums)))