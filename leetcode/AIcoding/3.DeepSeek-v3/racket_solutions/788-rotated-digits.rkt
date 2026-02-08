(define (rotated-digits N)
  (define (is-good? num)
    (let loop ([n num] [valid #f])
      (if (zero? n)
          valid
          (let ([d (remainder n 10)])
            (cond
              [(or (= d 3) (= d 4) (= d 7)) #f]
              [(or (= d 0) (= d 1) (= d 8)) (loop (quotient n 10) valid)]
              [else (loop (quotient n 10) #t)])))))
  (let count ([i 1] [res 0])
    (if (> i N)
        res
        (count (+ i 1) (if (is-good? i) (+ res 1) res)))))