(define/contract (rune-reserve runes)
  (-> (listof exact-integer?) exact-integer?)
  (let ([sorted (sort runes <)])
    (define (helper lst prev max-count count)
      (cond
        [(null? lst) max-count]
        [(<= (abs (- (car lst) prev)) 1)
         (helper (cdr lst) (car lst) (max max-count (+ count 1)) (+ count 1))]
        [else
         (helper (cdr lst) (car lst) (max max-count 1) 1)]))
    (if (null? sorted)
        0
        (helper (cdr sorted) (car sorted) 1 1))))