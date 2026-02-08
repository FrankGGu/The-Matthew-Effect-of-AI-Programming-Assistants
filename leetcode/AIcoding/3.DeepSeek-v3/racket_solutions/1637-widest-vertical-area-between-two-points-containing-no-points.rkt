(define/contract (max-width-of-vertical-area points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([sorted (sort points (lambda (a b) (< (car a) (car b))))]
         [xs (map car sorted)]
         [max-width 0])
    (for ([i (in-range 1 (length xs))])
      (let ([width (- (list-ref xs i) (list-ref xs (- i 1)))])
        (when (> width max-width)
          (set! max-width width))))
    max-width))