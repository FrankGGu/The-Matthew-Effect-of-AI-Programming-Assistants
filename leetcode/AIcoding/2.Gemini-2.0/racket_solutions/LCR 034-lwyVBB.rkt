(define (is-alien-sorted? words order)
  (define order-map (make-hash))
  (for ([i (in-range (string-length order))])
    (hash-set! order-map (string-ref order i) i))

  (define (compare-words word1 word2)
    (let loop ([i 0])
      (cond
        [(and (= i (string-length word1)) (= i (string-length word2))) 0]
        [(= i (string-length word1)) -1]
        [(= i (string-length word2)) 1]
        [else
         (let ([char1 (string-ref word1 i)]
               [char2 (string-ref word2 i)])
           (let ([order1 (hash-ref order-map char1 #f)]
                 [order2 (hash-ref order-map char2 #f)])
             (cond
               [(= order1 order2) (loop (+ i 1))]
               [(< order1 order2) -1]
               [else 1])))])))

  (let loop ([prev (first words)]
             [rest (rest words)])
    (cond
      [(null? rest) #t]
      [else
       (if (<= (compare-words prev (first rest)) 0)
           (loop (first rest) (rest rest))
           #f)])))