(define (minimum-score s t)
  (define n (string-length s))
  (define m (string-length t))
  (define prefix (make-vector (add1 m) n))
  (define suffix (make-vector (add1 m) n))
  (vector-set! prefix 0 -1)
  (vector-set! suffix m n)
  (for ([i (in-range 0 m)])
    (let loop ([j 0])
      (cond
        [(>= j n) (vector-set! prefix (add1 i) (vector-ref prefix i))]
        [(char=? (string-ref s j) (string-ref t i))
         (vector-set! prefix (add1 i) j)
         ]
        [else (loop (add1 j))])))
  (for ([i (in-range (- m 1) -1 -1)])
    (let loop ([j (- n 1)])
      (cond
        [(< j 0) (vector-set! suffix i (vector-ref suffix (add1 i)))]
        [(char=? (string-ref s j) (string-ref t i))
         (vector-set! suffix i j)
         ]
        [else (loop (- j 1))])))

  (define (check-prefix-suffix i j)
    (and (<= 0 i m)
         (<= 0 j m)
         (<= i j)
         (<= (vector-ref prefix i) (vector-ref suffix j))))

  (let loop ([len m]
             [ans m])
    (cond
      [(zero? len) ans]
      [else
       (let loop2 ([i 0])
         (cond
           [(> i (- m len)) ans]
           [else
            (if (check-prefix-suffix i (+ i len))
                (min ans len)
                (loop2 (add1 i))))])))
  (let loop ([len m]
             [ans m])
    (cond
      [(zero? len) ans]
      [else
       (let loop2 ([i 0])
         (cond
           [(> i (- m len)) ans]
           [else
            (if (check-prefix-suffix i (+ i len))
                (loop (- len 1) (min ans len))
                (loop2 (add1 i))))])))))