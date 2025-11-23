(define/contract (chalk-replacer chalk k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([total (apply + chalk)]
         [k (remainder k total)])
    (let loop ([i 0] [sum 0])
      (if (>= sum k)
          i
          (loop (add1 i) (+ sum (list-ref chalk i))))))