(define/contract (search-range nums target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define (binary-search left right find-first)
    (let loop ([left left] [right right] [result -1])
      (if (> left right)
          result
          (let* ([mid (quotient (+ left right) 2)]
                 [mid-val (list-ref nums mid)])
            (cond
              [(< mid-val target) (loop (add1 mid) right result)]
              [(> mid-val target) (loop left (sub1 mid) result)]
              [else
               (if find-first
                   (loop left (sub1 mid) mid)
                   (loop (add1 mid) right mid))])))))
  (let ([first-pos (binary-search 0 (sub1 (length nums)) #t)])
    (if (= first-pos -1)
        '(-1 -1)
        (let ([last-pos (binary-search first-pos (sub1 (length nums)) #f)])
          (list first-pos last-pos)))))