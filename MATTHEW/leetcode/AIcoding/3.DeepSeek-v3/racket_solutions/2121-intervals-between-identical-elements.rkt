(define/contract (distances arr)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length arr)]
         [pos-hash (make-hash)]
         [prefix-hash (make-hash)]
         [result (make-vector n 0)])
    (for ([i (in-range n)]
          [num (in-list arr)])
      (hash-update! pos-hash num (lambda (lst) (cons i lst)) '()))
    (for ([(num lst) (in-hash pos-hash)])
      (let* ([lst (reverse lst)]
             [m (length lst)]
             [prefix (make-vector m 0)])
        (vector-set! prefix 0 (list-ref lst 0))
        (for ([i (in-range 1 m)])
          (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (list-ref lst i)))
        (hash-set! prefix-hash num prefix)))
    (for ([(num lst) (in-hash pos-hash)])
      (let* ([lst (reverse lst)]
             [m (length lst)]
             [prefix (hash-ref prefix-hash num)])
        (for ([k (in-range m)]
              [i (in-list lst)])
          (let* ([left (if (= k 0) 0 (+ (* k (list-ref lst k)) (- (vector-ref prefix (sub1 k))))]
                 [right (if (= k (sub1 m)) 0 (- (+ (* (- (sub1 m) k) (list-ref lst k)) (- (vector-ref prefix (sub1 m)) (vector-ref prefix k))))])
            (vector-set! result i (+ left right))))))
    (vector->list result)))