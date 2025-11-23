#lang racket

(define (power-of-heroes nums)
  (define MOD 1000000007)

  (define sorted-nums (sort nums <))
  (define N (length sorted-nums))

  (define total-power 0)
  (define current-sum-min-contributions 0)

  (for ([i (in-range N)]
        [num (in-list sorted-nums)])
    (let* ([num-val (exact->integer num)]
           [num-sq (modulo (* num-val num-val) MOD)]
           [num-cubed (modulo (* num-sq num-val) MOD)])

      (set! total-power (modulo (+ total-power num-cubed) MOD))

      (when (> i 0)
        (let ([contribution-from-min-elements (modulo (* num-sq current-sum-min-contributions) MOD)])
          (set! total-power (modulo (+ total-power contribution-from-min-elements) MOD))))

      (set! current-sum-min-contributions
            (modulo (+ (modulo (* 2 current-sum-min-contributions) MOD) num-val) MOD))))

  total-power)