#lang racket

(require racket/set)

(define (minimum-pushes word)
  (let* ([distinct-chars (for/fold ([s (set)])
                                   ([c (in-string word)])
                                   (set-add s c))]
         [num-distinct (set-count distinct-chars)])
    (let loop ([remaining-chars num-distinct]
               [current-push-cost 1]
               [total-pushes 0])
      (if (zero? remaining-chars)
          total-pushes
          (let* ([chars-at-this-cost (min remaining-chars 9)]
                 [pushes-for-this-level (* chars-at-this-cost current-push-cost)])
            (loop (- remaining-chars chars-at-this-cost)
                  (+ current-push-cost 1)
                  (+ total-pushes pushes-for-this-level)))))))