(define/contract (make-equal words)
  (-> (listof string?) boolean?)
  (let* ([counts (make-hash)]
         [n (length words)])
    (for ([word words])
      (for ([c (string->list word)])
        (hash-update! counts c add1 (lambda () 0)))
    (for/and ([(k v) (in-hash counts)])
      (zero? (modulo v n)))))