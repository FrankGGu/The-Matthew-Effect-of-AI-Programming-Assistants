(define (second-largest digit-string)
  (define digits (filter (lambda (c) (and (char? c) (char>=? c #\0) (char<=? c #\9))) (string->list digit-string)))
  (define unique-digits (remove-duplicates (map (lambda (c) (- (char->integer c) (char->integer #\0))) digits)))
  (define sorted-digits (sort unique-digits >))
  (if (>= (length sorted-digits) 2)
      (list-ref sorted-digits 1)
      -1))

(second-largest "abc12345") ; Example call