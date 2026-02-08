(define (num-unique-emails emails)
  (define (sanitize-email email)
    (let* ([parts (string-split email "@" #:keep-empty? #t)]
           [local (car parts)]
           [domain (cadr parts)]
           [plus-index (string-index local #\+)]
           [sanitized-local (if plus-index (substring local 0 plus-index) local)]
           [cleaned-local (string-replace sanitized-local "." "")])
      (string-append cleaned-local "@" domain)))
  (define unique-emails (make-hash))
  (for-each (lambda (email)
              (hash-set! unique-emails (sanitize-email email) #t))
            emails)
  (hash-count unique-emails))