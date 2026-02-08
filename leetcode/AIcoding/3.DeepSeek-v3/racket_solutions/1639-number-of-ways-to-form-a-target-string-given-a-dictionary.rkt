#lang racket

(define (num-ways words target)
  (define n (string-length (car words)))
  (define m (string-length target))
  (define MOD 1000000007)

  (define cnt (make-vector n (make-hash)))
  (for ([word words])
    (for ([i (in-range n)]
          [c (in-string word)])
      (hash-update! (vector-ref cnt i) c (lambda (x) (add1 x)) 0)))

  (define dp (make-vector (add1 m) (make-vector (add1 n) 0)))
  (for ([j (in-range (add1 n))]) (vector-set! (vector-ref dp 0) j 1))

  (for ([i (in-range 1 (add1 m))])
    (for ([j (in-range 1 (add1 n))])
      (define c (string-ref target (sub1 i)))
      (define ways (hash-ref (vector-ref cnt (sub1 j)) c 0))
      (define val (+ (vector-ref (vector-ref dp i) (sub1 j))
                     (* ways (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))))
      (vector-set! (vector-ref dp i) j (modulo val MOD))))

  (vector-ref (vector-ref dp m) n))