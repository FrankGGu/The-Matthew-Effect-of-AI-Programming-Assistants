(define/contract (is-match s p)
  (-> string? string? boolean?)
  (let ((m (string-length s))
        (n (string-length p)))
    (let dp ((i 0) (j 0))
      (cond
        [(= j n) (= i m)]
        [(and (< j n) (char=? (string-ref p j) #\*))
         (or (dp i (+ j 1)) (and (< i m) (dp (+ i 1) j)))]
        [(and (< i m) (< j n)
         (and (or (char=? (string-ref p j) #\?)
                  (char=? (string-ref p j) (string-ref s i)))
              (dp (+ i 1) (+ j 1)))]
        [else #f]))))