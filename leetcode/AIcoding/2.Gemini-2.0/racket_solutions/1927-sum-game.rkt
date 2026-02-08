(define (sum-game nums)
  (let* ([n (length nums)]
         [question-marks (count (lambda (x) (equal? x #\?)) nums)]
         [alice-moves (quotient question-marks 2)]
         [bob-moves (- question-marks alice-moves)])
    (if (odd? question-marks)
        #t
        (let* ([sum-alice 0]
               [sum-bob 0]
               [left (take nums (/ n 2))]
               [right (drop nums (/ n 2))])
          (for ([i (in-range (/ n 2))])
            (cond
              [(equal? (list-ref left i) #\?) (set! sum-alice (+ sum-alice 1))]
              [else (set! sum-alice (+ sum-alice (string->number (string (list-ref left i)))))]))
          (for ([i (in-range (/ n 2))])
            (cond
              [(equal? (list-ref right i) #\?) (set! sum-bob (+ sum-bob 1))]
              [else (set! sum-bob (+ sum-bob (string->number (string (list-ref right i)))))]))

          (if (= sum-alice sum-bob)
              #f
              (if (= sum-alice sum-bob)
                  #f
                  (let ([diff-moves (- sum-alice sum-bob)])
                    (if (zero? diff-moves)
                        #f
                        (if (zero? question-marks)
                            (not (= sum-alice sum-bob))
                            (if (= alice-moves bob-moves)
                                (not (= sum-alice sum-bob))
                                (let ([diff-moves (- sum-alice sum-bob)]
                                      [diff-question-marks (- sum-alice sum-bob)])
                                  (not (= (* 2 diff-moves) (* 9 diff-question-marks))))))))))))))