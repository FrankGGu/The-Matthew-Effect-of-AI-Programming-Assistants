(require srfi/1) ; For sort
(require srfi/13) ; For list-ref, not strictly needed with match
(require srfi/26) ; For cut, not strictly needed with match
(require racket/match) ; For match

(define (minimum-cost cost)
  (let* ([sorted-cost (sort cost >)])
    (let loop ([remaining-candies sorted-cost]
               [total-cost 0])
      (match remaining-candies
        ['() total-cost]
        [(list c1) (+ total-cost c1)]
        [(list c1 c2) (+ total-cost c1 c2)]
        [(list c1 c2 c3 . rest)
         (loop rest (+ total-cost c1 c2))]
        ))))