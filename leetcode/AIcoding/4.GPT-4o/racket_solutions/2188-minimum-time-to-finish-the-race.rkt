(define (minTimeToFinishRace dist speed)
  (define (canFinishInTime time)
    (for/sum ([d dist])
      (ceiling (/ d speed))))

  (define (binary-search left right)
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (canFinishInTime mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))

  (binary-search 1 (* 10 (apply max dist)))
)

(define (minTimeToFinishRace dist speed)
  (minTimeToFinishRace dist speed))