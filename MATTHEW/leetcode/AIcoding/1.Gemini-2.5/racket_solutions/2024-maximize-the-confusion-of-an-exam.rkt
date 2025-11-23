(define (max-consecutive answerKey k char-to-change)
  (let* ([n (string-length answerKey)]
         [left 0]
         [count 0]
         [max-len 0])
    (for ([right (in-range n)])
      (when (char=? (stringref answerKey right) char-to-change)
        (set! count (+ count 1)))
      (let loop ()
        (when (> count k)
          (when (char=? (stringref answerKey left) char-to-change)
            (set! count (- count 1)))
          (set! left (+ left 1))
          (loop)))
      (set! max-len (max max-len (- right left -1))))
    max-len))

(define (maximize-confusion answerKey k)
  (max (max-consecutive answerKey k #\F)
       (max-consecutive answerKey k #\T)))