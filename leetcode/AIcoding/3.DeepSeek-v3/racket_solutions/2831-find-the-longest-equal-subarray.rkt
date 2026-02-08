(define/contract (longest-equal-subarray nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right 0] [max-count 0] [counts (hash)] [max-freq 0])
    (if (>= right (length nums))
        max-freq
        (let* ([num (list-ref nums right)]
               [new-counts (hash-update counts num add1 (lambda () 0))]
               [new-freq (max max-freq (hash-ref new-counts num))])
          (if (> (- (add1 (- right left)) new-freq) k)
              (loop (add1 left) (add1 right) max-count (hash-update counts (list-ref nums left) sub1) max-freq)
              (loop left (add1 right) (max max-count (add1 (- right left))) new-counts new-freq))))))