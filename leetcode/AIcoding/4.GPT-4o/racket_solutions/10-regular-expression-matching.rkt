(define (is-match s p)
  (define (match i j)
    (cond
      [(= j (string-length p)) (= i (string-length s))]
      [(and (< i (string-length s))
            (or (= (string-ref p j) (string-ref s i))
                (= (string-ref p j) #\.))
            (match (+ i 1) (+ j 1)))]
      [(and (< j (- (string-length p) 1))
            (= (string-ref p (+ j 1)) #\*)
            (match i (+ j 2))]
      [(and (< j (- (string-length p) 1))
            (= (string-ref p (+ j 1)) #\*)
            (or (and (< i (string-length s))
                     (or (= (string-ref p j) (string-ref s i))
                         (= (string-ref p j) #\.))
                     (match (+ i 1) j))
                (match i (+ j 2))))]
      [else #f]))
  (match 0 0))

(define (isMatch s p)
  (is-match s p))