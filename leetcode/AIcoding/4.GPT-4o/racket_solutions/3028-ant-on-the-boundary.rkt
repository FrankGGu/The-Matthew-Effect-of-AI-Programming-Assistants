(define (antOnBoundary n t)
  (let loop ((pos 1) (time 0))
    (if (= time t)
        pos
        (loop (if (or (= pos 1) (= pos n))
                  (+ pos (* -1 (if (= pos 1) 1 -1)))
                  pos)
              (+ time 1)))))