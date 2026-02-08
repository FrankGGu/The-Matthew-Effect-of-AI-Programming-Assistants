(define (isMatch s p)
  (define (match i j)
    (cond
      [(= j (string-length p)) (= i (string-length s))]
      [(and (< i (string-length s)) (= (string-ref p j) #\?) (match (+ i 1) (+ j 1)))]
      [(and (< i (string-length s)) (= (string-ref p j) (string-ref s i)) (match (+ i 1) (+ j 1)))]
      [(and (< j (string-length p)) (= (string-ref p j) #\*) (or (match i (+ j 1)) (and (< i (string-length s)) (match (+ i 1) j))))]
      [else #f]))
  (match 0 0))