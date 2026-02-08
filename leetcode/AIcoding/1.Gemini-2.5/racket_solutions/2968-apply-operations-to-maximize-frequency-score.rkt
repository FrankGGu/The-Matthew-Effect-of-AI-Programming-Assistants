#lang racket

(define (max-frequency nums k)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)]
         [sorted-vec (list->vector sorted-nums)])
    (let loop ([left 0]
               [current-sum 0]
               [max-freq 0]
               [right 0])
      (if (= right n)
          max-freq
          (let* ([num-at-right (vector-ref sorted-vec right)]
                 [temp-sum (+ current-sum num-at-right)])
            (let adjust-window ([current-left left]
                                [current-window-sum temp-sum])
              (let* ([window-length (+ (- right current-left) 1)]
                     [cost (- (* window-length num-at-right) current-window-sum)])
                (if (> cost k)
                    (adjust-window (+ current-left 1)
                                   (- current-window-sum (vector-ref sorted-vec current-left)))
                    (loop current-left
                          current-window-sum
                          (max max-freq window-length)
                          (+ right 1))))))))))