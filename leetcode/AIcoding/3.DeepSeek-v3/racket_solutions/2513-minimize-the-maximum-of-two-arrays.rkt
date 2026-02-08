(define/contract (minimize-set divisor1 divisor2 uniqueCnt1 uniqueCnt2)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? exact-integer?)
  (define (lcm a b)
    (quotient (* a b) (gcd a b)))
  (define l (lcm divisor1 divisor2))
  (define (enough? m)
    (let* ([not-div1 (quotient m divisor1)]
           [not-div2 (quotient m divisor2)]
           [not-div-both (quotient m l)]
           [avail1 (- m not-div1)]
           [avail2 (- m not-div2)]
           [total-avail (- (+ avail1 avail2) (- m not-div-both))])
      (and (>= avail1 uniqueCnt1)
           (>= avail2 uniqueCnt2)
           (>= total-avail (+ uniqueCnt1 uniqueCnt2)))))
  (let binary-search ([lo 1] [hi (+ (* uniqueCnt1 divisor1) (* uniqueCnt2 divisor2))])
    (if (= lo hi)
        lo
        (let ([mid (quotient (+ lo hi) 2)])
          (if (enough? mid)
              (binary-search lo mid)
              (binary-search (+ mid 1) hi))))))