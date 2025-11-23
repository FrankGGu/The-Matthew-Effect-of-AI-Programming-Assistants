#lang racket

(define (max-frequency nums f)
  (define (helper i j curr max-freq)
    (if (>= i (length nums))
        max-freq
        (let ((current-value (list-ref nums i)))
          (if (<= (+ curr current-value) f)
              (helper (+ i 1) j (+ curr current-value) (max max-freq (+ (- i j) 1)))
              (helper i (+ j 1) (- curr (list-ref nums j)) max-freq)))))
  (helper 0 0 0 0))

(define/contract (max-frequency-elements nums f)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (max-frequency nums f))