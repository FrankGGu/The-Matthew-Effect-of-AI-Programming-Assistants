#lang racket

(define (is-number s)
  (define (is-digit c)
    (char>=? c #\0)
    (char<=? c #\9))
  (define (is-sign c)
    (or (char=? c #\+) (char=? c #\-)))
  (define (is-e c)
    (char=? c #\e))
  (define (is-dot c)
    (char=? c #\.))
  (define (is-valid s)
    (let loop ([i 0] [has-dot? #f] [has-e? #f] [has-sign? #f] [has-digit? #f])
      (cond
        [(= i (string-length s)) has-digit?]
        [else
         (let ([c (string-ref s i)])
           (cond
             [(is-sign c)
              (if (or has-sign? has-digit? has-e?)
                  #f
                  (loop (+ i 1) has-dot? has-e? #t has-digit?))]
             [(is-e c)
              (if (or has-e? (not has-digit?))
                  #f
                  (loop (+ i 1) has-dot? #t has-sign? #f))]
             [(is-dot c)
              (if (or has-dot? has-e?)
                  #f
                  (loop (+ i 1) #t has-e? has-sign? has-digit?))]
             [(is-digit c)
              (loop (+ i 1) has-dot? has-e? has-sign? #t)]
             [else #f]))]))
  (is-valid s))