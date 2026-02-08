(define/contract (maximum-rows-covered matrix cols)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define max-covered 0)

  (define (count-covered selected-cols)
    (define covered 0)
    (for ([row matrix])
      (define all-covered? #t)
      (for ([i (in-range n)] #:break (not all-covered?))
        (when (and (= (list-ref row i) 1)
                   (not (member i selected-cols)))
          (set! all-covered? #f)))
      (when all-covered? (set! covered (add1 covered))))
    covered)

  (define (combinations lst k)
    (cond [(= k 0) '(())]
          [(null? lst) '()]
          [else (append (map (lambda (x) (cons (car lst) x))
                            (combinations (cdr lst) (sub1 k)))
                       (combinations (cdr lst) k)]))

  (for ([selected (combinations (range n) cols)])
    (define covered (count-covered selected))
    (when (> covered max-covered)
      (set! max-covered covered)))

  max-covered)