(define (count-matches items ruleKey ruleValue)
  (let ([idx (cond
               [(string=? ruleKey "type") 0]
               [(string=? ruleKey "color") 1]
               [(string=? ruleKey "name") 2]
               [else -1])])
    (for/sum ([item items])
      (if (string=? (list-ref item idx) ruleValue)
          1
          0))))