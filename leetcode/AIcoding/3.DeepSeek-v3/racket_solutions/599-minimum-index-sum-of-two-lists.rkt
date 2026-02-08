(define/contract (find-restaurant list1 list2)
  (-> (listof string?) (listof string?) (listof string?))
  (let ([index-sum +inf.0]
        [result '()])
    (for ([(r1 i) (in-indexed list1)])
      (let ([j (index-of list2 r1)])
        (when j
          (let ([sum (+ i j)])
            (cond
              [(< sum index-sum)
               (set! index-sum sum)
               (set! result (list r1))]
              [(= sum index-sum)
               (set! result (cons r1 result))])))))
    (reverse result)))