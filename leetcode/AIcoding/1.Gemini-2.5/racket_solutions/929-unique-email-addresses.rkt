#lang racket

(define (num-unique-emails emails)
  (define (normalize-email email-str)
    (let* ([parts (string-split email-str "@")]
           [local-name (car parts)]
           [domain-name (cadr parts)]
           [plus-index (string-index-of local-name #\+)]
           [processed-local-name
            (let* ([local-without-plus
                    (if plus-index
                        (substring local-name 0 plus-index)
                        local-name)]
                   [local-without-dots
                    (regexp-replace* #rx"\\." local-without-plus "")])
              local-without-dots)])
      (string-append processed-local-name "@" domain-name)))

  (define normalized-emails-set (make-set))
  (for-each
   (lambda (email)
     (set-add! normalized-emails-set (normalize-email email)))
   emails)
  (set-count normalized-emails-set))