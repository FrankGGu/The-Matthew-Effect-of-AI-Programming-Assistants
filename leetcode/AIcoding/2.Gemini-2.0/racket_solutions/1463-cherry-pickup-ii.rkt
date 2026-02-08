(define (cherry-pickup grid)
  (define rows (length grid))
  (define cols (length (first grid)))

  (define (in-bounds? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define memo (make-hash))

  (define (dp r c1 c2)
    (cond
      [(>= r rows) 0]
      [(hash-has-key? memo (list r c1 c2)) (hash-ref memo (list r c1 c2))]
      [else
       (let* ([curr-cherries (+ (list-ref (list-ref grid r) c1)
                                (if (= c1 c2) 0 (list-ref (list-ref grid r) c2)))]
              [max-cherries 0])
         (for ([dc1 (in-list '(-1 0 1))])
           (for ([dc2 (in-list '(-1 0 1))])
             (let ([next-c1 (+ c1 dc1)]
                   [next-c2 (+ c2 dc2)])
               (when (and (in-bounds? (add1 r) next-c1) (in-bounds? (add1 r) next-c2))
                 (set! max-cherries (max max-cherries (dp (add1 r) next-c1 next-c2)))))))
         (let ([result (+ curr-cherries max-cherries)])
           (hash-set! memo (list r c1 c2) result)
           result))]))

  (dp 0 0 (- cols 1)))