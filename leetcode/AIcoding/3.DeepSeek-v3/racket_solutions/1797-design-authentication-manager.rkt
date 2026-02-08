(define auth-manager%
  (class object%
    (super-new)
    (init-field time-to-live)

    (define tokens (make-hash))

    (define/public (generate token-id current-time)
      (hash-set! tokens token-id (+ current-time time-to-live)))

    (define/public (renew token-id current-time)
      (when (hash-has-key? tokens token-id)
        (let ([expiry-time (hash-ref tokens token-id)])
          (when (> expiry-time current-time)
            (hash-set! tokens token-id (+ current-time time-to-live))))))

    (define/public (count-unexpired-tokens current-time)
      (let ([count 0])
        (hash-for-each tokens
          (lambda (k v)
            (when (> v current-time)
              (set! count (+ count 1)))))
        count)))
)

(define (make-authentication-manager time-to-live)
  (new auth-manager% [time-to-live time-to-live]))