#lang racket

(struct transaction (name time amount city original-string) #:transparent)

(define (parse-transaction-string s)
  (define parts (string-split s ","))
  (transaction (list-ref parts 0)
               (string->number (list-ref parts 1))
               (string->number (list-ref parts 2))
               (list-ref parts 3)
               s))

(define (invalid-transactions transactions)
  (define parsed-transactions (map parse-transaction-string transactions))
  (define invalid-set (make-hash-set))

  (for ([tx1 parsed-transactions]
        [i (in-naturals)])
    (when (> (transaction-amount tx1) 1000)
      (hash-set-add! invalid-set (transaction-original-string tx1)))

    (for ([tx2 parsed-transactions]
          [j (in-naturals)])
      (when (not (= i j))
        (when (and (string=? (transaction-name tx1) (transaction-name tx2))
                   (not (string=? (transaction-city tx1) (transaction-city tx2)))
                   (<= (abs (- (transaction-time tx1) (transaction-time tx2))) 60))
          (hash-set-add! invalid-set (transaction-original-string tx1)))))
    )
  (hash-set->list invalid-set))