(define (sum-of-total-strength strength)
  (define n (length strength))
  (define mod (+ 1e9 7))

  (define prefix-sum (make-vector (+ n 1) 0))
  (for ((i (in-range 1 (+ n 1))))
    (vector-set! prefix-sum i (modulo (+ (vector-ref prefix-sum (- i 1)) (list-ref strength (- i 1))) mod)))

  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (define (find-left i)
    (let loop ((j (- i 1)))
      (cond
        ((< j 0) i)
        ((<= (list-ref strength j) (list-ref strength i)) i)
        (else (loop (vector-ref left j))))))

  (define (find-right i)
    (let loop ((j (+ i 1)))
      (cond
        ((>= j n) i)
        ((< (list-ref strength j) (list-ref strength i)) i)
        (else (loop (vector-ref right j))))))

  (for ((i (in-range n)))
    (vector-set! left i (find-left i)))

  (for ((i (in-range (- n 1) -1 -1)))
    (vector-set! right i (find-right i)))

  (define result 0)
  (for ((i (in-range n)))
    (define l (vector-ref left i))
    (define r (vector-ref right i))

    (define left-count (- i l))
    (define right-count (- r i))

    (define left-sum (modulo (- (* (+ left-count 1) (vector-ref prefix-sum (+ i 1))) (vector-ref prefix-sum l)) mod))
    (define right-sum (modulo (- (* (+ right-count 1) (vector-ref prefix-sum l)) (vector-ref prefix-sum (- (+ i 1) (+ left-count 1)))) mod))

    (define total-sum (modulo (- left-sum right-sum) mod))
    (define strength-contribution (modulo (* (list-ref strength i) total-sum) mod))

    (set! result (modulo (+ result strength-contribution) mod)))

  result)