(define/contract (merge-triplets triplets target)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) boolean?)
  (define (valid? triplet)
    (and (<= (first triplet) (first target))
         (<= (second triplet) (second target))
         (<= (third triplet) (third target)))
  (define filtered (filter valid? triplets))
  (if (null? filtered)
      #f
      (let ([a (apply max (map first filtered))]
            [b (apply max (map second filtered))]
            [c (apply max (map third filtered))])
        (and (= a (first target)) (= b (second target)) (= c (third target))))))