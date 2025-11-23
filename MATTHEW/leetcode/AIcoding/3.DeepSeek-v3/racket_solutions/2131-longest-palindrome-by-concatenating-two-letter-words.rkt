(define/contract (longest-palindrome words)
  (-> (listof string?) exact-integer?)
  (let* ([count (make-hash)]
         [same-count (make-hash)]
         [result 0])
    (for ([word words])
      (if (equal? (string-ref word 0) (string-ref word 1))
          (hash-update! same-count word add1 0)
          (hash-update! count word add1 0)))
    (let ([has-odd #f])
      (hash-for-each same-count (lambda (k v)
                                 (if (even? v)
                                     (set! result (+ result v))
                                     (begin
                                       (set! result (+ result (sub1 v)))
                                       (set! has-odd #t)))))
      (if has-odd (set! result (add1 result)) (void)))
    (hash-for-each count (lambda (k v)
                          (let* ([rev (string (string-ref k 1) (string-ref k 0))]
                                 [rev-count (hash-ref count rev 0)]))
                          (set! result (+ result (* 2 (min v rev-count))))))
    (* 2 result)))