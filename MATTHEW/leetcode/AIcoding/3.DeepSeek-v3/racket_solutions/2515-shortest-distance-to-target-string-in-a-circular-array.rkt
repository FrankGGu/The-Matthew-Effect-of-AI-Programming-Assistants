(define/contract (closet-target words target startIndex)
  (-> (listof string?) string? exact-integer? exact-integer?)
  (let loop ([left startIndex] [right startIndex] [steps 0] [n (length words)])
    (cond
      [(string=? (list-ref words left) target) steps]
      [(string=? (list-ref words right) target) steps]
      [(and (= (modulo (sub1 left) n) (modulo (add1 right) n) (= steps (sub1 n))) -1]
      [else (loop (modulo (sub1 left) n) (modulo (add1 right) n) (add1 steps) n)])))