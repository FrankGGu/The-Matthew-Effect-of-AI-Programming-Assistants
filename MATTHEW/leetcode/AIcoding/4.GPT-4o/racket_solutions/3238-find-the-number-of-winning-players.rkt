(define (countWinningPlayers scores)
  (define max-score (apply max scores))
  (define winning-count (count (lambda (x) (= x max-score)) scores))
  winning-count)

(define (findWinningPlayers scores)
  (countWinningPlayers scores))