(define (findWinningPlayer piles)
  (define (helper piles)
    (if (null? piles)
        0
        (+ (car piles) (- (helper (cdr piles)) (car piles)))))
  (if (>= (helper piles) 0)
      "Player 1"
      "Player 2"))

(findWinningPlayer '((1 2 3) (4 5 6)))