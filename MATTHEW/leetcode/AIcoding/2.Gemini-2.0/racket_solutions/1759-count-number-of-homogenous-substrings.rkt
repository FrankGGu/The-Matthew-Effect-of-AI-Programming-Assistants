(define (count-homogenous s)
  (define (helper s count current-len prev-char)
    (cond
      [(empty? s) (modulo (+ count (sum (range 1 (+ current-len 1)))) 1000000007)]
      [(char=? (first s) prev-char) (helper (rest s) count (+ current-len 1) prev-char)]
      [else (helper (rest s) (modulo (+ count (sum (range 1 (+ current-len 1)))) 1000000007) 1 (first s))]))

  (if (empty? s)
      0
      (helper (rest s) 0 1 (first s))))

(define (sum lst)
  (foldl + 0 lst))