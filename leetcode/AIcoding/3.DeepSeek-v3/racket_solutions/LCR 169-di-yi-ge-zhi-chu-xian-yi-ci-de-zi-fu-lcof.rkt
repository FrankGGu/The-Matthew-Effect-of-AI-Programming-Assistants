(define/contract (first-uniq-char s)
  (-> string? integer?)
  (let ([count (make-hash)])
    (for ([char (in-string s)])
      (hash-update! count char add1 0))
    (for ([i (in-range (string-length s))]
          #:when (= (hash-ref count (string-ref s i)) 1))
      (return i))
    -1))