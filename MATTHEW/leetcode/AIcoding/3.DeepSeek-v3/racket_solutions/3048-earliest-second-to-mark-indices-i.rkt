#lang racket

(require math)

(define (earliest-second-to-mark-indices-i nums changeIndices)
  (define n (length nums))
  (define m (length changeIndices))
  (define (can-mark? s)
    (define last (make-hash))
    (for ([i (in-range s)])
      (define idx (sub1 (list-ref changeIndices i)))
      (when (< idx n)
        (hash-set! last idx i)))
    (unless (= (hash-count last) n) #f)
    (define total 0)
    (for ([(idx lst) (in-hash last)])
      (define num (list-ref nums idx))
      (when (> (+ total num) lst) (set! total +inf.0) (break))
      (set! total (+ total num 1)))
    (<= total s))
  (define (binary-search left right)
    (if (> left right)
        -1
        (let* ([mid (quotient (+ left right) 2)]
               [valid (can-mark? mid)])
          (if valid
              (binary-search left (sub1 mid))
              (binary-search (add1 mid) right)))))
  (binary-search n m))

(define (solution nums changeIndices)
  (earliest-second-to-mark-indices-i nums changeIndices))