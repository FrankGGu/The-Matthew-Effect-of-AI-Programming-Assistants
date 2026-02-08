(define (rearrange-words text)
  (define lower-text (string-downcase text))
  (define words (string-split lower-text " "))

  (define sorted-words (sort words (lambda (a b) (< (string-length a) (string-length b)))))

  (if (empty? sorted-words)
      ""
      (begin
        (define first-word (car sorted-words))
        (define rest-words (cdr sorted-words))

        (define capitalized-first-word
          (string-append (string (char-upcase (string-ref first-word 0)))
                         (substring first-word 1 (string-length first-word))))

        (string-join (cons capitalized-first-word rest-words) " "))))