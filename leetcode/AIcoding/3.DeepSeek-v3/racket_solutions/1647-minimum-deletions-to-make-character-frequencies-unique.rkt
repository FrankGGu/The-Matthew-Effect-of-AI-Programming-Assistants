(define/contract (min-deletions s)
  (-> string? exact-integer?)
  (let* ([freq (make-hash)]
         [counts (make-hash)]
         [deletions 0])
    (for ([c (in-string s)])
      (hash-update! freq c add1 0))
    (for ([(k v) (in-hash freq)])
      (let loop ([v v])
        (cond
          [(zero? v) (void)]
          [(hash-has-key? counts v)
           (set! deletions (add1 deletions))
           (loop (sub1 v))]
          [else (hash-set! counts v #t)])))
    deletions))