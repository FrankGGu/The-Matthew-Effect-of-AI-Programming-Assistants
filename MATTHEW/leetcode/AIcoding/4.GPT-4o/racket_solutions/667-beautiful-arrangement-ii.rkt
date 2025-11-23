(define (constructArray n k)
  (let loop ((i 1) (j k) (result '()))
    (cond
      ((= i n) (append (reverse (cons i result)) (list i)))
      ((odd? i) (loop (+ i 1) j (cons i result)))
      (else (loop (+ i 1) (- j 1) (cons (if (> j 0) j (add1 i)) result))))))

(define (getPermutation n k) 
  (constructArray n k))