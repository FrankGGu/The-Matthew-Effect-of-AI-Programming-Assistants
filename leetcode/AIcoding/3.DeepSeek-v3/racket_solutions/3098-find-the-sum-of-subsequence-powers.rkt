(define/contract (sum-of-powers nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define MOD 1000000007)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define dp (make-hash))

  (define (helper pos prev count min-diff)
    (if (= count k)
        min-diff
        (if (>= pos n)
            0
            (let ([key (list pos prev count min-diff)])
              (if (hash-has-key? dp key)
                  (hash-ref dp key)
                  (let* ([num (list-ref sorted-nums pos)]
                         [new-min-diff (if (= count 0)
                                          MOD
                                          (min min-diff (- num prev)))]
                         [take (if (>= count 1)
                                  (helper (+ pos 1) num (+ count 1) new-min-diff)
                                  0)]
                         [not-take (helper (+ pos 1) prev count min-diff)]
                         [total (modulo (+ take not-take) MOD)])
                    (hash-set! dp key total)
                    total))))))

  (helper 0 0 0 MOD))