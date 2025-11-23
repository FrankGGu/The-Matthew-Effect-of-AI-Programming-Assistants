(define (decode-message key mapping)
  (define (char->code c)
    (let ((idx (string-index mapping c)))
      (if idx
          (string-ref "abcdefghijklmnopqrstuvwxyz" idx)
          c)))
  (define (process-str s)
    (list->string (map char->code (string->list s))))
  (process-str key))