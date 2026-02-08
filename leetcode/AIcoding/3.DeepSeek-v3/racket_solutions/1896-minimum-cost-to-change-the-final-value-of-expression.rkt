#lang racket

(define (min-cost-to-change-expression expr)
  (define n (string-length expr))
  (define (char-at i) (string-ref expr i))

  (define (helper left right)
    (if (= left right)
        (let ([c (char-at left)])
          (if (char=? c #\0)
              (values 1 0)
              (values 0 1)))
        (let ([op-pos (find-op-pos left right)])
          (let-values ([(l0 l1) (helper left (sub1 op-pos))]
                       [(r0 r1) (helper (add1 op-pos) right)])
            (let ([op (char-at op-pos)])
              (if (char=? op #\|)
                  (values (min l0 r0) (min (+ l0 r1) (min (+ l1 r0) (+ l1 r1))))
                  (values (min (+ l0 r0) (min (+ l0 r1) (+ l1 r0))) (min l1 r1))))))))

  (define (find-op-pos left right)
    (let loop ([i left] [balance 0])
      (let ([c (char-at i)])
        (cond
          [(and (zero? balance) (or (char=? c #\|) (char=? c #\&))) i]
          [(char=? c #\() (loop (add1 i) (add1 balance))]
          [(char=? c #\)) (loop (add1 i) (sub1 balance))]
          [else (loop (add1 i) balance)]))))

  (let-values ([(cost0 cost1) (helper 0 (sub1 n))])
    (min cost0 cost1)))