(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define *allowed-prev-rolls*
  (let ([allowed (make-vector 6)])
    (for ([j (in-range 6)])
      (define current-roll (+ j 1))
      (define prev-rolls '())
      (for ([i (in-range 6)])
        (define prev-roll (+ i 1))
        (when (and (!= i j) (= (gcd prev-roll current-roll) 1))
          (set! prev-rolls (cons i prev-rolls))))
      (vector-set! allowed j (reverse prev-rolls)))
    allowed))

(define MOD 1000000007)

(define (distinct-roll-sequences n)
  (define dp (make-vector 6 1))

  (for ([k (in-range 2 (+ n 1))])
    (define new-dp (make-vector 6 0))
    (for ([j (in-range 6)])
      (define current-sum 0)
      (for ([i (vector-ref *allowed-prev-rolls* j)])
        (set! current-sum (modulo (+ current-sum (vector-ref dp i)) MOD)))
      (vector-set! new-dp j current-sum))
    (set! dp new-dp))

  (define total-sum 0)
  (for ([val (in-vector dp)])
    (set! total-sum (modulo (+ total-sum val) MOD)))
  total-sum)