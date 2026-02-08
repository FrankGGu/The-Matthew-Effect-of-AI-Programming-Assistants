(define (arrange-words text)
  (let* ([words (string-split text " ")]
         [sorted-words (sort words (lambda (a b) (< (string-length a) (string-length b))))]
         [result (string-join sorted-words " ")]
         [first-char (string-ref result 0)]
         [rest (substring result 1)])
    (string-append (string (char-upcase first-char)) rest)))