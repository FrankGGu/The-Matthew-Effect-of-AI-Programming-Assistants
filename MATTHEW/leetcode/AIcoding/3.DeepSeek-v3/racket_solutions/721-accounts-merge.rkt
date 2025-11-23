(define (accounts-merge accounts)
  (let* ([email-to-name (make-hash)]
         [email-to-parent (make-hash)]
         [parent (lambda (email)
                  (let loop ([email email])
                    (if (equal? email (hash-ref email-to-parent email email))
                        email
                        (let ([p (hash-ref email-to-parent email)])
                          (hash-set! email-to-parent email (hash-ref email-to-parent p p))
                          (loop (hash-ref email-to-parent email))))))]
         [union (lambda (e1 e2)
                  (let ([p1 (parent e1)]
                        [p2 (parent e2)])
                    (unless (equal? p1 p2)
                      (hash-set! email-to-parent p1 p2))))])
    (for ([account accounts])
      (let ([name (first account)]
            [emails (rest account)])
        (for ([email emails])
          (hash-set! email-to-name email name)
          (hash-set! email-to-parent email email)))
      (for ([email (rest (rest account))])
        (union (second account) email)))
    (let ([trees (make-hash)])
      (for ([(email _) email-to-parent])
        (let ([p (parent email)])
          (hash-update! trees p (lambda (es) (cons email es)) '())))
      (for/list ([(p emails) trees])
        (cons (hash-ref email-to-name p) (sort (remove-duplicates emails) string<?))))))