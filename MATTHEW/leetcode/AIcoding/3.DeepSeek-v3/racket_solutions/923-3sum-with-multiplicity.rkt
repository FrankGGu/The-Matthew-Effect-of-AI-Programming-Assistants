(define/contract (three-sum-multi arr target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define MOD 1000000007)
  (define counts (make-hash))
  (for ([num arr])
    (hash-update! counts num add1 0))
  (define keys (sort (hash-keys counts) <))
  (define res 0)
  (for ([i (in-range (length keys))])
    (define x (list-ref keys i))
    (for ([j (in-range i (length keys))])
      (define y (list-ref keys j))
      (define z (- target x y))
      (when (hash-has-key? counts z)
        (cond
          [(< y z)
           (set! res (modulo (+ res (* (hash-ref counts x) (hash-ref counts y) (hash-ref counts z))) MOD))]
          [(= x y z)
           (set! res (modulo (+ res (* (hash-ref counts x) (sub1 (hash-ref counts x)) (sub1 (sub1 (hash-ref counts x))) / 6)) MOD)]
          [(= x y)
           (set! res (modulo (+ res (* (hash-ref counts x) (sub1 (hash-ref counts x)) / 2 (hash-ref counts z))) MOD)]
          [(= y z)
           (set! res (modulo (+ res (* (hash-ref counts x) (hash-ref counts y) (sub1 (hash-ref counts y))) / 2)) MOD)]
          [else (void)]))))
  res)