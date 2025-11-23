(define (stone-game-ix stones)
  (let ([mod-1 (count (lambda (x) (= (modulo x 3) 1)) stones)]
        [mod-2 (count (lambda (x) (= (modulo x 3) 2)) stones)])
    (cond
      [(= mod-1 0) (not (odd? mod-2))]
      [(= mod-2 0) (not (odd? mod-1))]
      [else (> (abs (- mod-1 mod-2)) 2)])))