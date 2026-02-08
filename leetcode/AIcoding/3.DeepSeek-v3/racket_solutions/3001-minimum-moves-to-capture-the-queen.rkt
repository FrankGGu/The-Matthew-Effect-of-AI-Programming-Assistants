(define (min-moves-to-capture-queen a b c d e f)
  (cond
    [(or (and (= a e) (or (not (= c e)) (not (between? d b f))))
         (and (= b f) (or (not (= d f)) (not (between? c a e))))
         (and (= (+ a b) (+ e f)) (or (not (= (+ c d) (+ e f))) (not (between? c a e)))
         (and (= (- a b) (- e f)) (or (not (= (- c d) (- e f))) (not (between? c a e)))) 1]
    [else 2]))