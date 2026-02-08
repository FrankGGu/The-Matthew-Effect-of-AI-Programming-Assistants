(define (count-matches items ruleKey ruleValue)
  (let ([index (cond
                 [(string=? ruleKey "type") 0]
                 [(string=? ruleKey "color") 1]
                 [(string=? ruleKey "name") 2])])
    (length (filter (lambda (item) (string=? (list-ref item index) ruleValue)) items))))