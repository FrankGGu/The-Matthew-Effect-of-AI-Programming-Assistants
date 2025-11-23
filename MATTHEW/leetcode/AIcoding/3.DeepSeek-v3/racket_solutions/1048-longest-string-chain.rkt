(define/contract (longest-str-chain words)
  (-> (listof string?) exact-integer?)
  (let* ([words (sort words (lambda (a b) (< (string-length a) (string-length b))))]
         [dp (make-hash)]
         [max-chain 1])
    (for ([word words])
      (hash-set! dp word 1)
      (for ([i (in-range (string-length word))])
        (let ([prev (string-append (substring word 0 i) (substring word (+ i 1) (string-length word)))])
          (when (hash-has-key? dp prev)
            (hash-set! dp word (max (hash-ref dp word) (+ (hash-ref dp prev) 1)))
            (set! max-chain (max max-chain (hash-ref dp word))))))
    max-chain))