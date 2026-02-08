(define/contract (find-smallest-integer nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([counts (make-hash)]
         [n (length nums)]
         [mods (for/list ([num nums])
                  (let ([mod (modulo num k)])
                    (if (negative? mod) (+ mod k) mod)))])
    (for ([mod mods])
      (hash-update! counts mod add1 0))
    (let loop ([m 0])
      (let ([mod (modulo m k)])
        (if (< (hash-ref counts mod 0) (quotient (+ m k) k))
            m
            (loop (+ m 1)))))))