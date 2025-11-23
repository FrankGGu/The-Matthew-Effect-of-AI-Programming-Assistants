#lang racket

(define (make-authentication-manager timeToLive)
  (let ([ttl timeToLive]
        [tokens (make-hash)])

    (define (generate token-id current-time)
      (hash-set! tokens token-id (+ current-time ttl)))

    (define (renew token-id current-time)
      (let ([existing-expiration-time (hash-ref tokens token-id #f)])
        (when (and existing-expiration-time
                   (> existing-expiration-time current-time))
          (hash-set! tokens token-id (+ current-time ttl)))))

    (define (count-unexpired-tokens current-time)
      (for/sum ([expiration-time (in-hash-values tokens)])
        (if (> expiration-time current-time) 1 0)))

    (list generate renew count-unexpired-tokens)))