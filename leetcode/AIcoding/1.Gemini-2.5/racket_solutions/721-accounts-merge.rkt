#lang racket

(define (accounts-merge accounts)
  (define parent (make-hash)) ; email -> parent_email
  (define email-to-name (make-hash)) ; email -> name (any name from the component is fine)

  (define (find x)
    (let ((p (hash-ref parent x x)))
      (if (eq? p x)
          x
          (let ((root (find p)))
            (hash-set! parent x root)
            root))))

  (define (union x y)
    (let ((root-x (find x))
          (root-y (find y)))
      (unless (eq? root-x root-y)
        (hash-set! parent root-x root-y))))

  (for-each (lambda (account)
              (let* ((name (car account))
                     (emails (cdr account)))
                (when (not (empty? emails))
                  (for-each (lambda (email)
                              (hash-set! parent email email)
                              (hash-set! email-to-name email name))
                            emails))))
            accounts)

  (for-each (lambda (account)
              (let ((emails (cdr account)))
                (when (not (empty? emails))
                  (let ((first-email (car emails)))
                    (for-each (lambda (email)
                                (union first-email email))
                              (cdr emails))))))
            accounts)

  (define merged-accounts-map (make-hash))

  (for-each (lambda (email)
              (let ((root (find email)))
                (hash-set! merged-accounts-map root (cons email (hash-ref merged-accounts-map root '())))))
            (hash-keys parent))

  (define result '())
  (for-each (lambda (root-email emails)
              (let* ((name (hash-ref email-to-name root-email))
                     (sorted-emails (sort emails string<?)))
                (set! result (cons (cons name sorted-emails) result))))
            merged-accounts-map)

  (reverse result))