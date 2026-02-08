#lang racket

(define/contract (max-matrix-sum matrix)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define m (length matrix))
  (define n (length (car matrix)))
  (define negatives 0)
  (define min-abs (expt 2 31)))
  (define total-sum 0)

  (for* ([i (in-range m)]
         [j (in-range n)])
    (define val (list-ref (list-ref matrix i) j))
    (when (< val 0)
      (set! negatives (add1 negatives)))
    (set! min-abs (min min-abs (abs val)))
    (set! total-sum (+ total-sum (abs val))))

  (if (odd? negatives)
      (- total-sum (* 2 min-abs))
      total-sum))