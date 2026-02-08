(define/contract (find-right-interval intervals)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (define n (length intervals))
  (define sorted (sort (for/list ([i (in-range n)] [interval intervals])
                         (list (first interval) i))
                       (lambda (a b) (< (first a) (first b)))))
  (define (binary-search target)
    (let loop ([left 0] [right (- n 1)])
      (if (> left right)
          -1
          (let* ([mid (quotient (+ left right) 2)]
                 [mid-val (first (list-ref sorted mid))])
            (cond
              [(= mid-val target) (second (list-ref sorted mid))]
              [(< mid-val target) (loop (+ mid 1) right)]
              [else (loop left (- mid 1))])))))
  (for/list ([interval intervals])
    (let ([target (second interval)])
      (if (empty? sorted)
          -1
          (let ([idx (binary-search target)])
            (if (>= idx 0)
                idx
                (let ([candidates (filter (lambda (x) (>= (first x) target)) sorted)])
                  (if (empty? candidates)
                      -1
                      (second (first candidates))))))))))