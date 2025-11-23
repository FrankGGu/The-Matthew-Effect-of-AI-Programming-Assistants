(define/contract (stone-game-vi alice-values bob-values)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length alice-values)]
         [pairs (sort (for/list ([a alice-values] [b bob-values] [i (in-range n)])
                      (lambda (x y) (> (+ (car x) (cadr x)) (+ (car y) (cadr y))))]
         [alice-score (for/sum ([i (in-range n)] #:when (even? i) (car (list-ref pairs i)))]
         [bob-score (for/sum ([i (in-range n)] #:when (odd? i) (cadr (list-ref pairs i)))])
    (cond [(> alice-score bob-score) 1]
          [(< alice-score bob-score) -1]
          [else 0])))