#lang racket

(define/contract (number-of-good-partitions nums)
  (-> (listof exact-integer?) exact-integer?)
  (define last-pos (make-hash))
  (for ([(num i) (in-indexed nums)])
    (hash-set! last-pos num i))

  (define MOD 1000000007)
  (define res 1)
  (define right 0)

  (for ([(num i) (in-indexed nums)])
    (set! right (max right (hash-ref last-pos num)))
    (when (= i right)
      (set! res (modulo (* res 2) MOD))
      (set! right (add1 right))
    )
  )
  res
)