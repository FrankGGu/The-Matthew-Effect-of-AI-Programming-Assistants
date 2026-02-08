(define/contract (maximum-value-sum nums k edges)
  (-> (listof exact-integer?) exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length nums)]
         [dp (make-hash)]
         [adj (make-vector n '())])
    (for ([edge edges])
      (let ([u (first edge)]
            [v (second edge)])
        (vector-set! adj u (cons v (vector-ref adj u)))
        (vector-set! adj v (cons u (vector-ref adj v)))))
    (define (dfs u parent)
      (let ([key (cons u parent)])
        (if (hash-has-key? dp key)
            (hash-ref dp key)
            (let* ([original (list-ref nums u)]
                   [xor (bitwise-xor original k)]
                   [total-original 0]
                   [total-xor 0])
              (for ([v (vector-ref adj u)] #:when (not (equal? v parent)))
                (let-values ([(child-original child-xor) (dfs v u)])
                  (set! total-original (+ total-original (max child-original child-xor)))
                  (set! total-xor (+ total-xor (max child-original child-xor)))))
              (let ([res-original (+ original total-original)]
                    [res-xor (+ xor total-xor)])
                (hash-set! dp key (cons res-original res-xor))
                (cons res-original res-xor))))))
    (let-values ([(res-original res-xor) (dfs 0 -1)])
      (max res-original res-xor))))