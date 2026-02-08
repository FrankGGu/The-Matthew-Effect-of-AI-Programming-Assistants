#lang racket

(define (撞色搭配 colors)
  (let* ((n (length colors))
         (total-pairs (/ (* n (- n 1)) 2))
         (freqs (make-hash)))

    (for-each (lambda (color)
                (hash-update! freqs color (lambda (v) (add1 (or v 0))) 0))
              colors)

    (let ((same-color-pairs 0))
      (hash-for-each (lambda (color count)
                       (when (> count 1)
                         (set! same-color-pairs (+ same-color-pairs (/ (* count (- count 1)) 2)))))
                     freqs)

      (- total-pairs same-color-pairs))))