#lang racket

(define (reorder-list head)
  (define (reverse-list node)
    (let loop ([prev #f] [curr node])
      (if (not curr) prev
          (loop curr (cdr curr) (cons (car curr) (reverse-list (cdr curr)))))))

  (define (get-middle node)
    (let loop ([slow node] [fast node])
      (if (or (not fast) (not (cdr fast))) slow
          (loop (cdr slow) (cddr fast)))))

  (define (merge-list l1 l2)
    (let loop ([l1 l1] [l2 l2] [result '()])
      (if (null? l1) (append (reverse result) l2)
          (loop (cdr l1) (if (null? l2) '() (cdr l2)) (cons (car l1) (cons (car l2) result))))))

  (if (or (null? head) (null? (cdr head))) head
      (let* ([mid (get-middle head)]
             [next (cdr mid)]
             [mid (set-cdr! mid '())]
             [reversed (reverse-list next)])
        (merge-list head reversed))))