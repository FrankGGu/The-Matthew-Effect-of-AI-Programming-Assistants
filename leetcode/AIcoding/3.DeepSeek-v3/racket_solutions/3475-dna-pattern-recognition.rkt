(define/contract (find-repeated-dna-sequences s)
  (-> string? (listof string?))
  (let loop ([i 0] [seen (hash)] [res (hash)])
    (if (>= (+ i 10) (string-length s))
        (hash-keys res)
        (let* ([sub (substring s i (+ i 10))]
               [new-seen (hash-set seen sub (add1 (hash-ref seen sub 0)))]
          (if (>= (hash-ref new-seen sub 0) 2)
              (loop (add1 i) new-seen (hash-set res sub #t))
              (loop (add1 i) new-seen res)))))