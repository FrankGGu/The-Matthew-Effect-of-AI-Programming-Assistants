#lang racket

(require racket/for)

(define (is-strictly-increasing lst)
  (cond
    [(or (empty? lst) (empty? (cdr lst))) #t]
    [else
     (let loop ([prev (car lst)]
                [rest (cdr lst)])
       (cond
         [(empty? rest) #t]
         [(< prev (car rest)) (loop (car rest) (cdr rest))]
         [else #f]))]))

(define (count-incremovable-subarrays nums)
  (let* ([n (length nums)]
         [count 0])
    (for ([i (in-range 0 n)])
      (for ([j (in-range i n)])
        (let* ([prefix (take nums i)]
               [suffix (drop nums (+ j 1))]
               [remaining (append prefix suffix)])
          (when (is-strictly-increasing remaining)
            (set! count (+ count 1))))))
    count))