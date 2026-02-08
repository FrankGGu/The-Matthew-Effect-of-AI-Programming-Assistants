(define (is-alien-sorted words order)
  (define order-map (make-hash))
  (for ([c (in-string order)]
        [i (in-naturals)])
    (hash-set! order-map c i))

  (define (compare w1 w2)
    (let loop ([i 0])
      (cond
        [(>= i (string-length w1)) #t]
        [(>= i (string-length w2)) #f]
        [else
         (let ([c1 (string-ref w1 i)]
               [c2 (string-ref w2 i)])
           (cond
             [(< (hash-ref order-map c1) (hash-ref order-map c2)) #t]
             [(> (hash-ref order-map c1) (hash-ref order-map c2)) #f]
             [else (loop (add1 i))]))])))

  (let loop ([i 0])
    (cond
      [(>= i (sub1 (length words))) #t]
      [else (and (compare (list-ref words i) (list-ref words (add1 i)))
                 (loop (add1 i)))])))