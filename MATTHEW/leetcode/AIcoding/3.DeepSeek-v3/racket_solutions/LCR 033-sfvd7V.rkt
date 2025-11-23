(define/contract (group-anagrams strs)
  (-> (listof string?) (listof (listof string?)))
  (let ([ht (make-hash)])
    (for ([s strs])
      (let* ([sorted (list->string (sort (string->list s) char<?))]
             [existing (hash-ref ht sorted '())])
        (hash-set! ht sorted (cons s existing))))
    (hash-values ht)))