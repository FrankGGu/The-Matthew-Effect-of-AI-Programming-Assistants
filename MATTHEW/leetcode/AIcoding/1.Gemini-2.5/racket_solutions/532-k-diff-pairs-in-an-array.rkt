#lang racket

(require racket/set)
(require racket/hash)

(define (find-pairs nums k)
  (cond
    [(< k 0) 0]
    [(= k 0)
     (let ([freq-map (make-hash)])
       (for-each (lambda (n)
                   (hash-update! freq-map n add1 0))
                 nums)
       (hash-count (lambda (num freq) (>= freq 2)) freq-map))]
    [(> k 0)
     (let ([unique-nums (list->set nums)])
       (set-count (lambda (n) (set-member? unique-nums (+ n k))) unique-nums))]))