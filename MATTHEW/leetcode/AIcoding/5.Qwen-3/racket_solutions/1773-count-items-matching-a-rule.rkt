(define (count-matching-rules items rule-key rule-value)
  (define (match? item)
    (cond
      [(equal? rule-key "type") (equal? (list-ref item 0) rule-value)]
      [(equal? rule-key "color") (equal? (list-ref item 1) rule-value)]
      [(equal? rule-key "name") (equal? (list-ref item 2) rule-value)]
      [else #f]))
  (length (filter match? items)))