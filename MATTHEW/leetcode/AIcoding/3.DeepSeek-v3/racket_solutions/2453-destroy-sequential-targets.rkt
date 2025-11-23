(define/contract (destroy-targets nums space)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([count (make-hash)]
         [max-count 0]
         [result +inf.0])
    (for ([num (in-list nums)])
      (define key (modulo num space))
      (hash-update! count key add1 0)
      (set! max-count (max max-count (hash-ref count key))))
    (for ([num (in-list nums)])
      (define key (modulo num space))
      (when (= (hash-ref count key) max-count)
        (set! result (min result num))))
    result))