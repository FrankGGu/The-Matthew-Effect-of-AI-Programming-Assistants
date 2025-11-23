(define (can-convert s t)
  (if (equal? (string-length s) (string-length t))
      (let loop ((i 0) (j 0))
        (cond
          [(= i (string-length s)) (= j (string-length t))]
          [(char=? (string-ref s i) (string-ref t j)) (loop (+ i 1) (+ j 1))]
          [(and (< j (string-length t)) 
                (char=? (string-ref s i) (string-ref t (+ j 1))) 
                (not (char=? (string-ref t j) (string-ref t (+ j 1))))) 
           (loop (+ i 1) (+ j 2))]
          [else #f]))
      #f))

(define (makeEqual strs)
  (let ((s (car strs))
        (t (cadr strs)))
    (can-convert s t)))

(makeEqual '("abc" "cba"))