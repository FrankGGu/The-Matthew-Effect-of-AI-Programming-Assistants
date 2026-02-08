(define/contract (num-unique-emails emails)
  (-> (listof string?) exact-integer?)
  (define (process-email email)
    (let* ([parts (string-split email "@")]
           [local (car parts)]
           [domain (cadr parts)]
           [local-no-plus (car (string-split local "+"))]
           [local-no-dots (string-replace local-no-plus "." "")])
      (string-append local-no-dots "@" domain)))

  (length (remove-duplicates (map process-email emails))))