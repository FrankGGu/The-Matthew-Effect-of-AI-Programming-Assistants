(define (min-valid-strings source target)
  (let ([n (string-length source)]
        [m (string-length target)])
    (let loop ([i 0] [j 0] [count 0])
      (cond
        [(= j m) count]
        [(= i n) #f]
        [(string=? (substring source i (+ i (min (- m j) n))) (substring target j (+ j (min (- m j) n))))
         (let ([len (min (- m j) n)])
           (let ([next-count (loop (+ i len) (+ j len) (+ count 1))])
             (if next-count
                 next-count
                 (loop (+ i 1) j count))))]
        [else (loop (+ i 1) j count)]))))