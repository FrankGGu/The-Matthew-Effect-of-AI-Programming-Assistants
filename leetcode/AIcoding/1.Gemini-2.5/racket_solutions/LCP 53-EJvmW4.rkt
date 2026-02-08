#lang racket

(define (strictly-increasing? lst)
  (or (empty? lst)
      (let loop ([prev (car lst)]
                 [rest (cdr lst)])
        (or (empty? rest)
            (and (< prev (car rest))
                 (loop (car rest) (cdr rest)))))))

(define (count-incremovable-subarrays nums)
  (let* ([n (length nums)]
         [count 0])

    (for ([i (in-range 0 n)])
      (for ([j (in-range i n)])
        (let* ([left-part (take nums i)]
               [right-part (drop nums (+ j 1))])

          (when (and (strictly-increasing? left-part)
                     (strictly-increasing? right-part)
                     (or (or (empty? left-part) (empty? right-part))
                         (< (last left-part) (car right-part))))
            (set! count (+ count 1))))))
    count))