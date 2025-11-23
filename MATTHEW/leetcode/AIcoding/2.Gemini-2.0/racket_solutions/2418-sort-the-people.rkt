(define (sort-people names heights)
  (define people (map list names heights))
  (define sorted-people (sort people > #:key second))
  (map first sorted-people))