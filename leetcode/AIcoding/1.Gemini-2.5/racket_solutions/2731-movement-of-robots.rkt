#lang racket

(define (movement-of-robots nums s d)
  (let* ([n (length nums)]
         [MOD 1000000007]
         [initial-positions nums]
         [directions (string->list s)]
         [new-positions
          (map (lambda (pos dir)
                 (if (char=? dir #\L)
                     (- pos d)
                     (+ pos d)))
               initial-positions
               directions)]
         [sorted-positions (sort new-positions <)])
    (let loop ([k 0] [total 0] [current-sorted-list sorted-positions])
      (if (null? current-sorted-list)
          total
          (let* ([pk (car current-sorted-list)]
                 [coefficient (- (* 2 k) (- n 1))]
                 [term (* coefficient pk)])
            (loop (+ k 1)
                  (modulo (+ total term) MOD)
                  (cdr current-sorted-list)))))))