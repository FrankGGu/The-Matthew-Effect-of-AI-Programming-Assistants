(define/contract (count-distinct-integers nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (reverse-number n)
    (let loop ([n n] [res 0])
      (if (zero? n)
          res
          (loop (quotient n 10) (+ (* res 10) (remainder n 10))))))
  (define all-nums
    (append nums (map reverse-number nums)))
  (length (remove-duplicates all-nums =)))