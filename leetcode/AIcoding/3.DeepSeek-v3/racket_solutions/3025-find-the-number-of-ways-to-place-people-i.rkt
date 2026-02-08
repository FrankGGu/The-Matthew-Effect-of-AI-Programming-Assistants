(define/contract (number-of-ways-to-place-people points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([sorted-points (sort points (lambda (a b) (or (< (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))]
        [n (length points)]
        [res 0])
    (for ([i (in-range n)])
      (for ([j (in-range (add1 i) n)])
        (let ([x1 (car (list-ref sorted-points i))]
              [y1 (cadr (list-ref sorted-points i))]
              [x2 (car (list-ref sorted-points j))]
              [y2 (cadr (list-ref sorted-points j))])
          (let ([valid #t])
            (for ([k (in-range n)])
              (let ([xk (car (list-ref sorted-points k))]
                   [yk (cadr (list-ref sorted-points k))])
                (when (and (<= x1 xk x2) (<= (min y1 y2) yk (max y1 y2)))
                  (unless (or (and (= xk x1) (= yk y1)) (and (= xk x2) (= yk y2)))
                    (set! valid #f)))))
            (when valid
              (set! res (add1 res))))))
    res))