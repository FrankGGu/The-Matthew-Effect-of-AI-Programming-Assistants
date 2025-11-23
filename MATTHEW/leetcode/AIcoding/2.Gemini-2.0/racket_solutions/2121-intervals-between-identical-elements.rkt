(define (intervals arr)
  (let* ([n (length arr)]
         [indices (make-hash)]
         [result (make-vector n 0)])
    (for/list ([i (in-range n)])
      (let ([x (list-ref arr i)])
        (hash-update! indices x (lambda (v) (cons i v)) (list i))))
    (for/list ([x (in-hash-keys indices)])
      (let* ([lst (hash-ref indices x)]
             [len (length lst)])
        (for/list ([i (in-range len)])
          (let ([idx (list-ref lst i)])
            (vector-set! result idx
                         (foldl + 0 (map (lambda (j) (abs (- idx j))) lst)))))))
    (vector->list result)))