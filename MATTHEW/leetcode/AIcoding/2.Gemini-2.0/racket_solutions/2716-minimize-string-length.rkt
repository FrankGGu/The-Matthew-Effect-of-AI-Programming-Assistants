(define (minimize-string-length s)
  (length (list->set (string->list s))))