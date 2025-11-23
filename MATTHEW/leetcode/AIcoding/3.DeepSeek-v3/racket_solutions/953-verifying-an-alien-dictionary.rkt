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
        [(< (hash-ref order-map (string-ref w1 i))
            (hash-ref order-map (string-ref w2 i))) #t]
        [(> (hash-ref order-map (string-ref w1 i))
            (hash-ref order-map (string-ref w2 i))) #f]
        [else (loop (add1 i))])))
  (for/and ([i (in-range (sub1 (length words)))])
    (compare (list-ref words i) (list-ref words (add1 i)))))