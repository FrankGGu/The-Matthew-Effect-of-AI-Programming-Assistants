(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (subseq-gcd nums)
  (define n (length nums))
  (define result 0)
  (define (count-subsequences i current-gcd)
    (if (= i n)
        (if (= current-gcd (car nums))
            1
            0)
        (+ (count-subsequences (+ i 1) current-gcd)
           (count-subsequences (+ i 1) (gcd current-gcd (list-ref nums i))))))
  (for ([i (in-range n)])
    (set! result (+ result (count-subsequences 0 (list-ref nums i)))))
  result)

(define (num-subseq nums)
  (define sorted-nums (sort nums <))
  (subseq-gcd sorted-nums))

(define (numSubseq nums)
  (num-subseq nums))