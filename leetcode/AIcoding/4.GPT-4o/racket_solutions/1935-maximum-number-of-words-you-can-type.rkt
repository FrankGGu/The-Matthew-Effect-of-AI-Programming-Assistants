(define (can-type? text broken-letters)
  (for/all ([char (string->list text)])
    (not (member char (string->list broken-letters)))))

(define (max-words typed-text broken-letters)
  (define words (string-split typed-text))
  (define valid-words (filter (lambda (word) (can-type? word broken-letters)) words))
  (length valid-words))

(define (count-words typed-text broken-letters)
  (max-words typed-text broken-letters))