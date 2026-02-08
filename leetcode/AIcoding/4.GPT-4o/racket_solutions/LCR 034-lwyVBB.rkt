(define (isAlienSorted words order)
  (define order-map (hash))
  (for ([i (in-range (string-length order))])
    (hash-set! order-map (string-ref order i) i))

  (define (compare-words w1 w2)
    (let loop ([i 0])
      (cond
        [(= i (min (string-length w1) (string-length w2))) 
         (< (string-length w1) (string-length w2))]
        [(not (= (string-ref w1 i) (string-ref w2 i)) 
                (let ([c1 (hash-ref order-map (string-ref w1 i))] 
                      [c2 (hash-ref order-map (string-ref w2 i))])
                  (< c1 c2)))]
        [else (loop (+ i 1))])))

  (for/fold ([prev (string "")] [is-sorted #t]) ([word words])
    (if (and is-sorted (compare-words prev word))
      (begin (set! prev word) #t)
      #f)))