#lang racket

(define (is-palindrome head)
  (define (reverse-list node)
    (let loop ([prev #f] [current node])
      (if (not current)
          prev
          (loop current (cdr current)))))

  (define (get-middle node)
    (let loop ([slow node] [fast node])
      (if (and fast (cdr fast))
          (loop (cdr slow) (cddr fast))
          slow)))

  (define (compare-list l1 l2)
    (cond [(not l1) #t]
          [(not l2) #f]
          [(= (car l1) (car l2)) (compare-list (cdr l1) (cdr l2))]
          [else #f]))

  (let* ([mid (get-middle head)]
         [reversed (reverse-list mid)])
    (compare-list head reversed)))