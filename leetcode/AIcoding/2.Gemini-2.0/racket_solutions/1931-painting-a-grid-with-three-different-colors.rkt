(define (color-the-grid m n)
  (define mod 1000000007)
  (define (generate-valid-states m)
    (let loop ([i 0] [current 0] [states '()])
      (if (= i m)
          (cons current states)
          (loop (+ i 1) (+ current (expt 3 i)) (loop (+ i 1) (+ current (* 2 (expt 3 i))) (loop (+ i 1) current states))))))

  (define valid-states (generate-valid-states m))

  (define (is-adjacent-valid? state1 state2 m)
    (let loop ([i 0])
      (if (= i m)
          #t
          (let ([color1 (modulo (quotient state1 (expt 3 i))) 3)]
            [color2 (modulo (quotient state2 (expt 3 i))) 3)]
            (if (= color1 color2)
                #f
                (loop (+ i 1)))))))

  (define adjacent-matrix
    (make-hash)
    )

  (for ([state1 valid-states])
    (hash-set! adjacent-matrix state1 '()))

  (for ([state1 valid-states])
    (for ([state2 valid-states])
      (if (is-adjacent-valid? state1 state2 m)
          (hash-set! adjacent-matrix state1 (cons state2 (hash-ref adjacent-matrix state1))))))

  (define dp (make-hash))

  (for ([state valid-states])
    (hash-set! dp (cons 1 state) 1))

  (for ([i (in-range 2 (+ n 1))])
    (for ([state valid-states])
      (let loop ([adj-states (hash-ref adjacent-matrix state)] [total 0])
        (if (null? adj-states)
            (hash-set! dp (cons i state) total)
            (loop (cdr adj-states) (modulo (+ total (hash-ref dp (cons (- i 1) (car adj-states)))) mod)))))
    )

  (let loop ([states valid-states] [total 0])
    (if (null? states)
        total
        (loop (cdr states) (modulo (+ total (hash-ref dp (cons n (car states)))) mod))))
  )