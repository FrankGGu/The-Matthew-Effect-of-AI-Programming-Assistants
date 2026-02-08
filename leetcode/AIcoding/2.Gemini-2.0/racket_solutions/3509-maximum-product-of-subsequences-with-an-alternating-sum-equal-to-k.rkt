(define (max-product-subsequences-with-alternating-sum-equal-k nums k)
  (define n (length nums))
  (define memo (make-hash))

  (define (solve idx sum-diff product even?)
    (cond
      [(>= idx n)
       (if (= sum-diff k)
           product
           -inf.0)]
      [(hash-has-key? memo (list idx sum-diff product even?))
       (hash-ref memo (list idx sum-diff product even?))]
      [else
       (define choice1 (solve (+ idx 1) sum-diff product even?))
       (define choice2 (if even?
                           (solve (+ idx 1) (+ sum-diff (list-ref nums idx)) (* product (list-ref nums idx)) (not even?))
                           (solve (+ idx 1) (- sum-diff (list-ref nums idx)) product (not even?))))
       (define result (max choice1 choice2))
       (hash-set! memo (list idx sum-diff product even?) result)
       result]))

  (define ans (solve 0 0 1 #t))
  (if (equal? ans -inf.0)
      -1
      (inexact->exact (round ans))))