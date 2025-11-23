(require racket/dict
         racket/set)

(define (accounts-merge accounts)
  (define email-to-account (make-hash))
  (define email-to-name (make-hash))
  (define graph (make-hash))

  (for ([account accounts])
    (define name (first account))
    (for ([email (rest account)])
      (hash-set! email-to-name email name)
      (hash-set! email-to-account email account)
      (hash-set! graph email (set))))

  (for ([account accounts])
    (define first-email (second account))
    (for ([email (drop account 2)])
      (define adj-set (hash-ref graph first-email))
      (hash-set! graph first-email (set-add adj-set email))
      (define adj-set (hash-ref graph email))
      (hash-set! graph email (set-add adj-set first-email))))

  (define visited (make-hash))
  (define result (list))

  (define (dfs email current-account)
    (hash-set! visited email #t)
    (set! current-account (sort (cons email current-account) string<?))
    (for ([neighbor (set->list (hash-ref graph email))])
      (unless (hash-ref visited neighbor #f)
        (set! current-account (dfs neighbor current-account))))
    current-account)

  (for ([email (hash-keys graph)])
    (unless (hash-ref visited email #f)
      (define current-account (dfs email (list)))
      (set! result (cons (cons (hash-ref email-to-name email) current-account) result))))

  (sort result (lambda (x y) (string<? (first x) (first y)))))