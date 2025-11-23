#lang racket

(define (minimum-score s t)
  (define n (string-length s))
  (define m (string-length t))
  (define left (make-vector (add1 m) 0))
  (define right (make-vector (add1 m) 0))

  (for ([i (in-range 1 (add1 m))])
    (define j (vector-ref left (sub1 i)))
    (define new-j (let loop ([j j])
                    (cond
                      [(= j n) n]
                      [(char=? (string-ref s j) (string-ref t (sub1 i))) (add1 j)]
                      [else (loop (add1 j))])))
    (vector-set! left i new-j))

  (vector-set! right m n)
  (for ([i (in-range (sub1 m) -1 -1)])
    (define j (vector-ref right (add1 i)))
    (define new-j (let loop ([j (sub1 j)])
                    (cond
                      [(= j -1) -1]
                      [(char=? (string-ref s j) (string-ref t i)) j]
                      [else (loop (sub1 j))])))
    (vector-set! right i new-j))

  (define min-score m)
  (let loop ([i 0] [j 0])
    (when (<= j m)
      (define l (vector-ref left i))
      (define r (vector-ref right j))
      (when (<= l r)
        (set! min-score (min min-score (- j i)))
        (loop i (add1 j)))
      (when (< j m)
        (loop (add1 i) j))))
  min-score)