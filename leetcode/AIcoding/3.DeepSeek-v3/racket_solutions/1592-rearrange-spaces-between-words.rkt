(define (reorder-spaces text)
  (let* ([words (filter non-empty-string? (string-split text " "))]
         [word-count (length words)]
         [space-count (count (lambda (c) (char=? c #\space)) (string->list text))]
         [spaces-per (if (> word-count 1) (quotient space-count (- word-count 1)) space-count)]
         [extra-spaces (if (> word-count 1) (remainder space-count (- word-count 1)) 0)]
         [space-str (make-string spaces-per #\space)]
         [result (string-join words space-str)])
    (if (zero? word-count)
        (make-string space-count #\space)
        (string-append result (make-string extra-spaces #\space)))))