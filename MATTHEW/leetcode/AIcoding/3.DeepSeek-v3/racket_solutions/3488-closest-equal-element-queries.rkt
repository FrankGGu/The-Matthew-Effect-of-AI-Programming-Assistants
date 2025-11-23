(define/contract (closest-equal queries nums queries)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([pos-map (make-hash)]
         [n (length nums)])
    (for ([num nums]
          [i (in-naturals)])
      (hash-update! pos-map num (lambda (lst) (cons i lst)) '()))
    (for/list ([q queries])
      (let* ([num (list-ref nums q)]
             [positions (sort (hash-ref pos-map num) <)]
             [idx (index-of positions q)])
        (cond
          [(= (length positions) 1) -1]
          [(= idx 0) (list-ref positions 1)]
          [(= idx (sub1 (length positions))) (list-ref positions (sub1 idx))]
          [else (let ([left (list-ref positions (sub1 idx))]
                  (let ([right (list-ref positions (add1 idx))])
                    (if (< (abs (- q left)) (abs (- q right)))
                        left
                        right)))])))))