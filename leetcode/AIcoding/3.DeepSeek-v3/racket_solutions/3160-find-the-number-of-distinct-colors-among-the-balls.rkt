(define/contract (query-results limit queries)
  (-> exact-integer? (listof (listof exact-integer?)) (listof exact-integer?))
  (let* ([color-map (make-hash)]
         [count-map (make-hash)]
         [distinct-colors 0]
         [result '()])
    (for ([query (in-list queries)])
      (let ([ball (first query)]
            [color (second query)])
        (when (hash-has-key? color-map ball)
          (let ([old-color (hash-ref color-map ball)])
            (hash-update! count-map old-color sub1)
            (when (zero? (hash-ref count-map old-color))
              (set! distinct-colors (sub1 distinct-colors))
              (hash-remove! count-map old-color))))
        (hash-set! color-map ball color)
        (hash-update! count-map color add1 0)
        (when (= (hash-ref count-map color) 1)
          (set! distinct-colors (add1 distinct-colors)))
        (set! result (cons distinct-colors result))))
    (reverse result)))