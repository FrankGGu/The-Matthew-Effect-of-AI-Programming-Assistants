#lang racket

(define (has-groups-size-x deck)
  (define freq-map (make-hash))

  (for-each (lambda (card)
              (hash-update! freq-map card (lambda (v) (add1 v)) 0))
            deck)

  (define frequencies (hash-values freq-map))

  (if (empty? frequencies)
      #f
      (>= (apply gcd frequencies) 2)))