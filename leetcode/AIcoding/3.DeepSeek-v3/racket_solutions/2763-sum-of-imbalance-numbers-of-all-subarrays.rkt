(define (sum-imbalance-numbers nums)
  (define n (length nums))
  (define total 0)
  (for ([i (in-range n)])
    (define seen (make-hash))
    (define imbalance 0)
    (for ([j (in-range i n)])
      (define num (list-ref nums j))
      (hash-set! seen num #t)
      (cond
        [(and (hash-has-key? seen (sub1 num)) (hash-has-key? seen (add1 num)))
         (set! imbalance (sub1 imbalance))]
        [(or (hash-has-key? seen (sub1 num)) (hash-has-key? seen (add1 num)))
         (void)]
        [else (set! imbalance (add1 imbalance))])
      (set! total (+ total imbalance))))
  total)