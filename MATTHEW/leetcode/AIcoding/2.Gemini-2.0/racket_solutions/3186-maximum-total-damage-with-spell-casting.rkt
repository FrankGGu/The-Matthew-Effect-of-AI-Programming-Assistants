(define (maximum-total-damage base-damage attack-power duration)
  (define n (length base-damage))
  (define spells (make-vector n))
  (for ([i (in-range n)])
    (vector-set! spells i (list (vector-ref base-damage i) (vector-ref attack-power i) (vector-ref duration i))))

  (define (calculate-damage chosen-spells)
    (define total-damage 0)
    (for ([spell chosen-spells])
      (set! total-damage (+ total-damage (car spell))))
    total-damage)

  (define (calculate-attack chosen-spells)
    (define attack 0)
    (for ([spell chosen-spells])
      (set! attack (+ attack (cadr spell))))
    attack)

  (define (calculate-duration chosen-spells)
    (define dur 0)
    (for ([spell chosen-spells])
      (set! dur (+ dur (caddr spell))))
    dur)

  (define (solve spells k)
    (let loop ([i 0] [current-spells '()] [max-damage 0])
      (cond
        [(>= i n)
         (if (= (length current-spells) k)
             (max max-damage (+ (calculate-damage current-spells) (* (calculate-attack current-spells) (calculate-duration current-spells))))
             max-damage)]
        [else
         (let ([include-damage (loop (+ i 1) (cons (vector-ref spells i) current-spells) max-damage)]
               [exclude-damage (loop (+ i 1) current-spells max-damage)])
           (max include-damage exclude-damage))]))
    )

  (define max-damage 0)
  (for ([k (in-range (add1 n))])
      (set! max-damage (max max-damage (solve spells k))))

  max-damage
  )