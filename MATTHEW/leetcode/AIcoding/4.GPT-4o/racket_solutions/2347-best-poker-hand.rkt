(define (best-poker-hand ranks)
  (define count (make-vector 14 0))
  (for-each (lambda (x) (vector-set! count x (+ 1 (vector-ref count x)))) ranks)
  (define max-count (apply max (vector->list count)))
  (cond
    [(= max-count 4) "Four of a Kind"]
    [(= max-count 3) "Three of a Kind"]
    [(= max-count 2) "One Pair"]
    [(> max-count 0) "High Card"]
    [else "High Card"]))

(define (bestPokerHand ranks)
  (best-poker-hand ranks))