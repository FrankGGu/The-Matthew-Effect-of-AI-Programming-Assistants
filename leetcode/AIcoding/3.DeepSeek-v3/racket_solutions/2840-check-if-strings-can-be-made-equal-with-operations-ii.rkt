(define/contract (check-strings s1 s2)
  (-> string? string? boolean?)
  (let* ([n (string-length s1)]
         [even-chars1 (make-hash)]
         [odd-chars1 (make-hash)]
         [even-chars2 (make-hash)]
         [odd-chars2 (make-hash)])
    (for ([i (in-range n)])
      (let ([c1 (string-ref s1 i)]
            [c2 (string-ref s2 i)])
        (if (even? i)
            (begin
              (hash-update! even-chars1 c1 add1 0)
              (hash-update! even-chars2 c2 add1 0))
            (begin
              (hash-update! odd-chars1 c1 add1 0)
              (hash-update! odd-chars2 c2 add1 0)))))
    (and (equal? even-chars1 even-chars2)
         (equal? odd-chars1 odd-chars2))))