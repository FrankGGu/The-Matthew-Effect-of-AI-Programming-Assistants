(define/contract (max-star-sum vals edges k)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define graph (make-hash))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (hash-update! graph u (lambda (lst) (cons v lst)) '())
      (hash-update! graph v (lambda (lst) (cons u lst)) '())))

  (define max-sum -inf.0)
  (for ([(node neighbors) graph])
    (define sorted-neighbors
      (sort (filter (lambda (v) (> (list-ref vals v) 0)) neighbors)
            (lambda (a b) (> (list-ref vals a) (list-ref vals b)))))
    (define current-sum
      (apply + (list-ref vals node)
             (take sorted-neighbors (min k (length sorted-neighbors)))))
    (set! max-sum (max max-sum current-sum)))

  (if (= max-sum -inf.0)
      (apply max vals)
      max-sum))