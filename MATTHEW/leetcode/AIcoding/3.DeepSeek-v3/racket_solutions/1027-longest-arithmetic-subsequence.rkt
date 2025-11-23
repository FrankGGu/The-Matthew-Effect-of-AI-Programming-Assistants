(define/contract (longest-arithmetic-subsequence nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)])
    (if (<= n 2) n
        (let ([dp (make-hash)]
              [max-len 2])
          (for ([i (in-range 1 n)])
            (for ([j (in-range 0 i)])
              (let* ([diff (- (list-ref nums i) (list-ref nums j))]
                     [prev-key (cons j diff)]
                     [current-key (cons i diff)]
                     [current-len (add1 (hash-ref dp prev-key 1))])
                (hash-set! dp current-key current-len)
                (set! max-len (max max-len current-len))))
          max-len)))