(define/contract (find-farmland land)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define m (length land))
  (define n (if (zero? m) 0 (length (car land))))
  (define res '())

  (define (dfs i j)
    (let loop ([r i] [c j])
      (cond
        [(or (>= r m) (>= c n) (cons (sub1 r) (sub1 c))]
        [(= (list-ref (list-ref land r) c) 1)
         (list-set! (list-ref land r) c 0)
         (loop r (add1 c))]
        [else (cons (sub1 r) (sub1 c))])))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (= (list-ref (list-ref land i) j) 1)
        (define top-left (list i j))
        (define bottom-right (dfs i j))
        (set! res (cons (append top-left bottom-right) res)))))

  (reverse res))