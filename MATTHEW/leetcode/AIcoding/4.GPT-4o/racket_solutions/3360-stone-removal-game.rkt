(define (stone-game-n n)
  (if (or (zero? n) (<= n 2))
      #t
      (not (stone-game-n (- n 2)))))

(define (stoneGame piles)
  (stone-game-n (apply + piles)))