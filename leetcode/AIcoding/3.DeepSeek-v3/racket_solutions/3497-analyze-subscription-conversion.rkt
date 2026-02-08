(define/contract (analyze-subscription-conversion subscription_events)
  (-> (listof (listof string?)) (listof (listof string?)))
  (define events (make-hash))
  (define conversions (make-hash))

  (for ([event subscription_events])
    (match event
      [(list user_id action timestamp)
       (hash-update! events user_id 
                      (lambda (actions) (cons action actions))
                      '())]))

  (for ([(user_id actions) (in-hash events)])
    (define has-signup (member "signup" actions))
    (define has-confirm (member "confirm" actions))
    (when (and has-signup has-confirm)
      (hash-update! conversions "signup_confirm" add1 0))
    (when has-signup
      (hash-update! conversions "signup" add1 0)))

  (define signup_confirm (hash-ref conversions "signup_confirm" 0))
  (define signup (hash-ref conversions "signup" 0))
  (define rate (if (= signup 0) "0.00" 
                   (real->decimal-string (/ signup_confirm signup) 2)))

  (list (list "signup_confirm" (number->string signup_confirm))
        (list "signup" (number->string signup))
        (list "conversion_rate" rate)))