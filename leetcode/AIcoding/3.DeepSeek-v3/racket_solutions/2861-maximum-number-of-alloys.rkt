#lang racket

(define/contract (max-number-of-alloys n k budget composition stock cost)
  (-> exact-integer? exact-integer? exact-integer? (listof (listof exact-integer?)) (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (can-make? target)
    (for/or ([comp composition])
      (define total-cost 0)
      (for ([metal comp] [s stock] [c cost])
        (define needed (max 0 (- (* metal target) s)))
        (set! total-cost (+ total-cost (* needed c)))
        (when (> total-cost budget) (break)))
      (<= total-cost budget)))

  (define (binary-search left right)
    (if (> left right)
        right
        (let* ([mid (quotient (+ left right) 2)]
               [valid? (can-make? mid)])
          (if valid?
              (binary-search (add1 mid) right)
              (binary-search left (sub1 mid))))))

  (binary-search 0 (add1 (apply max (map (lambda (s c) (if (zero? c) +inf.0 (quotient (+ budget s) c))) stock cost)))