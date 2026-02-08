(define/contract (display-table orders)
  (-> (listof (listof string?)) (listof (listof string?)))
  (define tables (make-hash))
  (define foods (mutable-set))
  (for ([order orders])
    (define table (string->number (second order)))
    (define food (third order))
    (set-add! foods food)
    (hash-update! tables table (lambda (cnt) (hash-update cnt food add1 0)) (hash)))

  (define sorted-foods (sort (set->list foods) string<?))
  (define sorted-tables (sort (hash-keys tables) <))

  (define header (cons "Table" sorted-foods))
  (define rows
    (for/list ([table sorted-tables])
      (define cnt (hash-ref tables table))
      (cons (number->string table)
            (for/list ([food sorted-foods])
              (number->string (hash-ref cnt food 0))))))

  (cons header rows))