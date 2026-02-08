(define (beautifulTowers n heights)
  (define (count-towers h)
    (let loop ((prev -1) (count 0) (i 0))
      (if (= i (length h))
          count
          (if (> (list-ref h i) prev)
              (loop (list-ref h i) (+ count 1) (+ i 1))
              (loop prev count (+ i 1))))))
  (count-towers (sort heights <)))

(define (beautifulTowersI heights)
  (beautifulTowers (length heights) heights))