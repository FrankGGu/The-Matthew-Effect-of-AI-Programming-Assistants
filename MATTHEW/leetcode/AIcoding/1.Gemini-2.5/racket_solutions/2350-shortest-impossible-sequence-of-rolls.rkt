#lang racket

(define (shortest-impossible-sequence-of-rolls rolls k)
  (let loop ([rolls-list rolls]
             [target 1]
             [seen (make-hash)])
    (cond
      [(> target k)
       (+ k 1)]
      [(empty? rolls-list)
       target]
      [else
       (let* ([current-roll (car rolls-list)]
              [rest-rolls (cdr rolls-list)]
              [new-seen seen])
         (when (and (>= current-roll 1) (<= current-roll k))
           (hash-set! new-seen current-roll #t))
         (if (hash-has-key? new-seen target)
             (loop rest-rolls (+ target 1) (make-hash))
             (loop rest-rolls target new-seen)))])))