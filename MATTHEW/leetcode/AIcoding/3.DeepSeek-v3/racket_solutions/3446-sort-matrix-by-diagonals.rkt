(define/contract (diagonal-sort mat)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define m (length mat))
  (define n (if (null? mat) 0 (length (car mat))))
  (define diagonals (make-hash))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (hash-update! diagonals (- i j) 
                    (lambda (lst) (cons (list-ref (list-ref mat i) j) lst))
                    '())))

  (for ([(key val) (in-hash diagonals)])
    (hash-set! diagonals key (sort val <)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (let* ([key (- i j)]
             [sorted-list (hash-ref diagonals key)]
             [val (car sorted-list)])
        (set! mat (list-set mat i (list-set (list-ref mat i) j val))
        (hash-set! diagonals key (cdr sorted-list)))))
  mat)