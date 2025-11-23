#lang racket

(require data/union-find)

(define (minimum-cost n edges query-array)
  (define uf (make-union-find n))
  (define cost (make-hash))

  (for ([edge edges])
    (match-define (list u v w) edge)
    (define ru (union-find-find uf u))
    (define rv (union-find-find uf v))
    (unless (equal? ru rv)
      (hash-set! cost ru (bitwise-and (hash-ref cost ru (lambda () (sub1 (expt 2 30)))) w))
      (hash-set! cost rv (bitwise-and (hash-ref cost rv (lambda () (sub1 (expt 2 30)))) w))
      (union-find-union! uf ru rv)
      (hash-set! cost (union-find-find uf ru) (bitwise-and (hash-ref cost ru) (hash-ref cost rv)))))

  (for/list ([query query-array])
    (match-define (list s t) query)
    (define rs (union-find-find uf s))
    (define rt (union-find-find uf t))
    (if (equal? rs rt)
        (hash-ref cost rs -1)
        -1)))