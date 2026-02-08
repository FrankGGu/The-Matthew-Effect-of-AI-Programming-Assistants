(define (subarrayLCM nums k)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (lcm a b)
    (if (or (= a 0) (= b 0))
        0
        (quotient (* a b) (gcd a b))))

  (define count 0)
  (define n (length nums))

  (for ([i (in-range n)])
    (define product 1)
    (for ([j (in-range i n)])
      (set! product (lcm product (list-ref nums j)))
      (if (= product k)
          (set! count (+ count 1)))))

  count)