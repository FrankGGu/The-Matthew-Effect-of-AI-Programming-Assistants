(define/contract (smaller-numbers-than-current nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define sorted (sort nums <))
  (define pos (make-hash))
  (for ([num sorted]
        [i (in-naturals)])
    (unless (hash-has-key? pos num)
      (hash-set! pos num i)))
  (map (lambda (x) (hash-ref pos x)) nums))