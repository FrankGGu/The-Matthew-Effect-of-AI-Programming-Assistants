(define (extract-spell spell)
  (string-join (remove-duplicates (string->list spell)) ""))