(define/contract (find-shortest-sub-array nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([left (make-hash)]
         [right (make-hash)]
         [count (make-hash)]
         [max-count 0])
    (for ([(num i) (in-indexed nums)])
      (when (not (hash-has-key? left num))
        (hash-set! left num i))
      (hash-set! right num i)
      (hash-update! count num add1 0)
      (set! max-count (max max-count (hash-ref count num))))
    (let ([result (length nums)])
      (for ([(num cnt) (in-hash count)])
        (when (= cnt max-count))
          (set! result (min result (+ 1 (- (hash-ref right num) (hash-ref left num))))))
      result)))