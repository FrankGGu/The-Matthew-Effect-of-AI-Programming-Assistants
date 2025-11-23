(define authentication-manager%
  (class object%
    (init-field time-to-live)
    (define table (make-hash))

    (define/public (generate token-id current-time)
      (hash-set! table token-id (+ current-time time-to-live)))

    (define/public (renew token-id current-time)
      (if (hash-has-key? table token-id)
          (let ([expiration-time (hash-ref table token-id)])
            (if (>= expiration-time current-time)
                (begin
                  (hash-set! table token-id (+ current-time time-to-live))
                  #t)
                #f))
          #f))

    (define/public (count-unexpired-tokens current-time)
      (let loop ([keys (hash-keys table)]
                 [count 0])
        (cond
          [(empty? keys) count]
          [else
           (let ([key (car keys)]
                 [expiration-time (hash-ref table key)])
             (if (> expiration-time current-time)
                 (loop (cdr keys) (+ count 1))
                 (loop (cdr keys) count)))])))

    (super-new)))

(define new AuthenticationManager
  (λ (time-to-live)
    (new authentication-manager% [time-to-live time-to-live])))