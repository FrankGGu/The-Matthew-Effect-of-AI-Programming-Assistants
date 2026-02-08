#lang racket

(define (longestCommonSubpath n path)
  (define (hash s)
    (foldl (lambda (x acc) (+ (* acc 31) x)) 0 s))

  (define (rolling-hash sub-path length)
    (define (calculate-hash start)
      (hash (subvector sub-path start (+ start length))))
    (define (next-hash current-hash start)
      (if (>= (+ start length) (vector-length sub-path))
          current-hash
          (next-hash (modulo (+ (* (- current-hash (hash (subvector sub-path start))) (expt 31 length)) (hash (subvector sub-path (+ start length)))) 1000000007) (+ start 1))))
    (next-hash (calculate-hash 0) 0))

  (define (check-length length)
    (define seen (make-hash))
    (for ([i (in-range (sub1 (vector-length path)) length)])
      (hash-set! seen (rolling-hash path length) #t))
    (for ([j (in-range (vector-length path))])
      (if (hash-has? seen (rolling-hash path length))
          (return-length length)))
    #f)

  (define low 1)
  (define high n)
  (define result 0)
  (while (<= low high)
    (define mid (inexact->exact (floor (/ (+ low high) 2))))
    (if (check-length mid)
        (begin (set! result mid) (set! low (+ mid 1)))
        (set! high (sub1 mid))))
  result)

(define (longestCommonSubpath-main n paths)
  (longestCommonSubpath n (vector->list paths)))