#lang racket

(require racket/set)

(define (get-prime-factors n)
  (let loop ((num n) (d 2) (factors (set)))
    (cond
      ((> (* d d) num)
       (if (> num 1)
           (set-add factors num)
           factors))
      ((zero? (remainder num d))
       (loop (let remove-d ((current-num num))
               (if (zero? (remainder current-num d))
                   (remove-d (/ current-num d))
                   current-num))
             (+ d 1)
             (set-add factors d)))
      (else
       (loop num (+ d 1) factors)))))

(define (distinct-prime-factors nums)
  (set-count
   (for/fold ((all-distinct-factors (set)))
             ((num nums))
     (set-union all-distinct-factors (get-prime-factors num)))))