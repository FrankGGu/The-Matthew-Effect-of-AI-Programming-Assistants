#lang racket

(require math)

(define (earliest-second-to-mark-indices-ii nums change-indices)
  (define n (length nums))
  (define m (length change-indices))
  (define (possible? s)
    (define last (make-hash))
    (for ([i (in-range s)])
      (define idx (sub1 (list-ref change-indices i)))
      (when (< idx n)
        (hash-set! last idx i)))
    (unless (= (hash-count last) n) #f)
    (define total 0)
    (for ([(idx last-day) (in-hash last)])
      (define num (list-ref nums idx))
      (when (> num (add1 last-day)) #f)
      (set! total (+ total num (if (zero? idx) 0 1))))
    (<= total (add1 s)))

  (define (binary-search left right)
    (if (> left right)
        -1
        (let* ([mid (quotient (+ left right) 2)]
               [valid (possible? mid)])
          (if valid
              (binary-search left (sub1 mid))
              (binary-search (add1 mid) right)))))

  (binary-search n m))

(define (main)
  (define nums (list 1 2 3))
  (define change-indices (list 1 3 2 1 2 3))
  (displayln (earliest-second-to-mark-indices-ii nums change-indices)))

(main)