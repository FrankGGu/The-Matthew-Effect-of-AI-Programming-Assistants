(define (finding-users-active-minutes logs)
  (define (parse-log log)
    (let ((parts (string-split log " ")))
      (values (car parts) (string->number (cadr parts)))))

  (define (process-user user-logs)
    (define unique-minutes (remove-duplicates (map cdr user-logs)))
    (length unique-minutes))

  (define users (make-hash))
  (for-each
   (lambda (log)
     (let-values (((user minute) (parse-log log)))
       (hash-update! users user (lambda (lst) (cons minute lst)) '())))
   logs)

  (define result (make-hash))
  (for-each
   (lambda (user)
     (let ((count (process-user (hash-ref users user))))
       (hash-update! result count (lambda (lst) (cons user lst)) '())))
   (hash-keys users))

  (hash->list result))