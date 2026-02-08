#lang racket

(define (find-secret-word wordlist master)
  (let loop ([words wordlist])
    (if (null? words)
        (void)
        (let* ([guess (car words)]
               [matches (send master 'guess guess)])
          (if (= matches 6)
              (void)
              (loop (filter (lambda (w) (= (count-matches guess w) matches)) (cdr words)))))))

(define (count-matches a b)
  (for/sum ([ca a] [cb b] #:when (char=? ca cb)) 1))