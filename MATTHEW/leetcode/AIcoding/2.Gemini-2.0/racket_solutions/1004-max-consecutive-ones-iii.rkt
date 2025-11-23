(define (max-consecutive-ones-iii nums k)
  (let loop ([left 0] [right 0] [zeros k] [max-len 0])
    (cond
      [(>= right (length nums)) max-len]
      [(= (list-ref nums right) 0)
       (cond
         [(= zeros 0)
          (let loop2 ([l left] [z zeros])
            (cond
              [(= (list-ref nums l) 0)
               (loop (+ l 1) (+ right 1) z (max max-len (- right left)))]
              [else (loop2 (+ l 1) z)]))]
         [else (loop left (+ right 1) (- zeros 1) (max max-len (- right left)))]
         )]
      [else (loop left (+ right 1) zeros (max max-len (- right left)))])))