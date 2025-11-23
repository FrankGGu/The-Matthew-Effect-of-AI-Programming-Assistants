(define (num-unique-emails emails)
  (define (process-email email)
    (let* ([local-part (car (string-split email "@"))]
           [domain-part (cadr (string-split email "@"))]
           [local-no-dots (string-replace local-part "." "")])
      (string-append local-no-dots "@" domain-part)))
  (define processed (map process-email emails))
  (length (remove-duplicates processed)))