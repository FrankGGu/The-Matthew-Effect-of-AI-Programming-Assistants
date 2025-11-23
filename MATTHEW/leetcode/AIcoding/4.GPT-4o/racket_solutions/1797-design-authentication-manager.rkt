(define AuthenticationManager
  (lambda ()
    (define tokens (hash))
    (define time-to-live 0)

    (define (renew token time)
      (if (hash-ref tokens token #f)
          (begin
            (hash-set! tokens token time)
            #t)
          #f))

    (define (generate token time)
      (hash-set! tokens token (+ time time-to-live)))

    (define (countUnexpiredTokens time)
      (hash-count (hash-filter (lambda (key value) (> value time)) tokens)))

    (define (setTimeToLive ttl)
      (set! time-to-live ttl))

    (define (expireTokens time)
      (hash-filter! (lambda (key value) (> value time)) tokens))

    (lambda (method . args)
      (cond
        ((equal? method 'renew) (apply renew args))
        ((equal? method 'generate) (apply generate args))
        ((equal? method 'countUnexpiredTokens) (apply countUnexpiredTokens args))
        ((equal? method 'setTimeToLive) (apply setTimeToLive args))
        ((equal? method 'expireTokens) (apply expireTokens args))))))

(define auth (AuthenticationManager))
((auth 'setTimeToLive) 5)
((auth 'generate) "token1" 1)
((auth 'countUnexpiredTokens) 2)
((auth 'renew) "token1" 6)
((auth 'countUnexpiredTokens) 6)
((auth 'expireTokens) 7)
((auth 'countUnexpiredTokens) 7)