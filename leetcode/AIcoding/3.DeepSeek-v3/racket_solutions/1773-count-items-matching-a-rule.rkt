(define/contract (count-matches items ruleKey ruleValue)
  (-> (listof (listof string?)) string? string? exact-integer?)
  (let ([key (case ruleKey
               [("type") 0]
               [("color") 1]
               [("name") 2])])
    (count (lambda (item) (equal? (list-ref item key) ruleValue)) items)))