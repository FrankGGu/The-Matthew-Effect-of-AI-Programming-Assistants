#lang racket

(define (beautiful-towers n towers)
  (define (is-beautiful? lst)
    (let loop ((lst lst) (prev -1) (count 0))
      (cond
        [(null? lst) #t]
        [(> (car lst) prev) (loop (cdr lst) (car lst) (+ count 1))]
        [else #f])))

  (define (count-beautiful lst)
    (if (is-beautiful? lst)
        1
        0))

  (define (backtrack idx)
    (if (= idx n)
        (count-beautiful towers)
        (apply + (map (lambda (h)
                        (let ((new-towers (list->vector (vector->list towers))))
                          (vector-set! new-towers idx h)
                          (backtrack (+ idx 1))))
                      (range 1 (+ n 1))))))

  (backtrack 0))

(define (beautifulTowers2 towers)
  (let ((n (vector-length towers)))
    (beautiful-towers n (vector->list towers))))