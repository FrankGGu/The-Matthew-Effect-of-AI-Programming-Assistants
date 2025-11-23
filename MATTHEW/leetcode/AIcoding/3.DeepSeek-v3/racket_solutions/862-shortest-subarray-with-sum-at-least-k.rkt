(define/contract (shortest-subarray nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define n (length nums))
  (define prefix (make-vector (add1 n) 0))
  (for ([i (in-range n)])
    (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref nums i))))

  (define q (make-deque))
  (deque-add-back! q 0)
  (define result +inf.0)

  (for ([i (in-range 1 (add1 n))])
    (while (and (not (deque-empty? q))
                (>= (- (vector-ref prefix i) (vector-ref prefix (deque-first q))) k))
      (set! result (min result (- i (deque-first q))))
      (deque-remove-front! q))

    (while (and (not (deque-empty? q))
                (<= (vector-ref prefix i) (vector-ref prefix (deque-last q))))
      (deque-remove-back! q))

    (deque-add-back! q i))

  (if (= result +inf.0) -1 (exact-round result)))