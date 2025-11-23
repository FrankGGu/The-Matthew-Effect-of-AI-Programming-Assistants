(define (find-original-typed-string s t)
  (define n (string-length s))
  (define m (string-length t))
  (define memo (make-hash))

  (define (dp i j)
    (cond
      [(hash-has-key? memo (cons i j)) (hash-ref memo (cons i j))]
      [(and (= i n) (= j m)) #t]
      [(or (= i n) (> j m)) #f]
      [(> i n) #f]
      [else
       (define ans
         (or
          (and (< i n) (< j m) (char=? (string-ref s i) (string-ref t j)) (dp (+ i 1) (+ j 1)))
          (and (< j m) (= i 0) (dp i (+ j 1)))
          (and (< i n) (< j m) (= i 0) (char=? (string-ref s i) (string-ref t j)) (dp (+ i 1) (+ j 1)))
          (and (< i n) (>= j 1) (char=? (string-ref s i) (string-ref t (- j 1)))
               (let loop ([k j])
                 (cond
                   [(>= k m) #f]
                   [(not (char=? (string-ref s i) (string-ref t k))) #f]
                   [else (or (dp (+ i 1) (+ k 1))
                             (loop (+ k 1)))])))
         ))
       (hash-set! memo (cons i j) ans)
       ans]))

  (if (dp 0 0) s #f))