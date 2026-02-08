(define/contract (most-frequent-even nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([filtered (filter even? nums)]
         [freq (make-hash)])
    (if (null? filtered)
        -1
        (begin
          (for ([num filtered])
            (hash-update! freq num add1 (lambda () 0)))
          (let* ([max-freq (apply max (hash-values freq))]
                 [candidates (filter (lambda (k) (= (hash-ref freq k) max-freq)) (hash-keys freq))])
            (apply min candidates))))))