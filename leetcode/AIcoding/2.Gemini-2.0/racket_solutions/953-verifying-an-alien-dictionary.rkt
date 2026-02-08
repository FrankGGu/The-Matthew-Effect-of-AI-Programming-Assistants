(define (is-alien-sorted? words order)
  (define order-map (make-hash))
  (for ([i (in-range (string-length order))])
    (hash-set! order-map (string-ref order i) i))

  (define (compare w1 w2)
    (let loop ([i 0])
      (cond
        [(and (= i (string-length w1)) (= i (string-length w2))) #t]
        [(= i (string-length w1)) #t]
        [(= i (string-length w2)) #f]
        [else
         (let ([c1 (string-ref w1 i)]
               [c2 (string-ref w2 i)])
           (cond
             [(= c1 c2) (loop (+ i 1))]
             [else (< (hash-ref order-map c1) (hash-ref order-map c2))]))])))

  (let loop ([prev (car words)]
             [rest (cdr words)])
    (cond
      [(null? rest) #t]
      [else
       (if (compare prev (car rest))
           (loop (car rest) (cdr rest))
           #f)])))