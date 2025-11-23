(define (getProbability box1 box2)
  (define (count-distinct balls)
    (length (remove-duplicates balls)))
  (define distinct1 (count-distinct box1))
  (define distinct2 (count-distinct box2))
  (if (= distinct1 distinct2)
      1.0
      0.0))

(getProbability '(1 2 1 2 3) '(1 2 3 4 5))