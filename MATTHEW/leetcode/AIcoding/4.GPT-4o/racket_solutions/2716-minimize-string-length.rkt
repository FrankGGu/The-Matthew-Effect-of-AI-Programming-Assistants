(define (minimize-string-length s)
  (length (remove-duplicates (string->list s))))