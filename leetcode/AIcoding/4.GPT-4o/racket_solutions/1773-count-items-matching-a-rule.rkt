(define (count-items matching-rules items)
  (define (matches-rule item)
    (and (equal? (hash-ref item 'type) (hash-ref matching-rules 'type))
         (equal? (hash-ref item 'color) (hash-ref matching-rules 'color))))
  (length (filter matches-rule items)))

(define (count-items-matching-rule items rule)
  (count-items rule items))