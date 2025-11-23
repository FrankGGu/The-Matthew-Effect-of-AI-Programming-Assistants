(define (maximum-distance arrays)
  (let* ([min-val (apply min (map car arrays))]
         [max-val (apply max (map (lambda (arr) (car (reverse arr))) arrays))]
         [res (- max-val min-val)])
    (if (and (null? arrays) (empty? arrays))
        0
        (let loop ([arrays arrays] [max-dist 0])
          (cond
            [(empty? arrays) max-dist]
            [else
             (let* ([curr-arr (car arrays)]
                    [curr-min (car curr-arr)]
                    [curr-max (car (reverse curr-arr))]
                    [temp-arrays (cdr arrays)]
                    [new-max-dist
                     (let loop2 ([temp-arrays temp-arrays] [curr-max-dist 0])
                       (cond
                         [(empty? temp-arrays) curr-max-dist]
                         [else
                          (let* ([other-arr (car temp-arrays)]
                                 [other-min (car other-arr)]
                                 [other-max (car (reverse other-arr))]
                                 [dist1 (abs (- curr-min other-max))]
                                 [dist2 (abs (- curr-max other-min))]
                                 [max-dist (max dist1 dist2)])
                            (loop2 (cdr temp-arrays) (max curr-max-dist max-dist)))]))])])
               (loop (cdr arrays) (max max-dist new-max-dist)))])))))