(define (findChampion i j)
  (define (helper a b)
    (if (= a b)
        a
        (helper (max a b) (min a b)))
  (helper i j))

(define (findChampions players)
  (foldl (lambda (player champion) (findChampion player champion)) (car players) (cdr players)))

(define (findChampionI players)
  (findChampions players))