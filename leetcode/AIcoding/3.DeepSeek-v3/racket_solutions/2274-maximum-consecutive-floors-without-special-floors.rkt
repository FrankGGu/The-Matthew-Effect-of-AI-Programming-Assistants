(define/contract (max-consecutive bottom top special)
  (-> exact-integer? exact-integer? (listof exact-integer?) exact-integer?)
  (let* ([special-sorted (sort special <)]
         [special-extended (cons bottom (append special-sorted (list top)))]
         [pairs (for/list ([i (in-range (sub1 (length special-extended)))])
                  (list (list-ref special-extended i) (list-ref special-extended (add1 i))))])
    (apply max (map (lambda (pair) 
                      (let ([left (add1 (first pair))] [right (sub1 (second pair))])
                        (if (<= left right) (- right left -1) 0))) pairs))))