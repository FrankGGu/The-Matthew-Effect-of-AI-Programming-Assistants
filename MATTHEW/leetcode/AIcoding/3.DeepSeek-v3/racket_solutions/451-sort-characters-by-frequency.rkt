(define/contract (frequency-sort s)
  (-> string? string?)
  (let* ([freq (make-hash)]
         [chars (string->list s)])
    (for ([c chars])
      (hash-update! freq c add1 (λ () 0)))
    (let* ([sorted (sort chars 
                         (λ (a b) 
                           (let ([cnt-a (hash-ref freq a)]
                                 [cnt-b (hash-ref freq b)])
                             (or (> cnt-a cnt-b)
                                 (and (= cnt-a cnt-b)
                                      (char<? a b))))))])
      (list->string sorted))))