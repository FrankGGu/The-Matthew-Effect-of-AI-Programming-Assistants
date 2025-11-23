#lang racket

(define (remove-nth-node-from-end-of-list head n)
  (define (get-length node)
    (if (null? node)
        0
        (+ 1 (get-length (cdr node)))))

  (define len (get-length head))
  (define target (- len n))

  (define (remove node index)
    (if (null? node)
        #f
        (if (= index 0)
            (cdr node)
            (cons (car node) (remove (cdr node) (- index 1))))))

  (if (= target 0)
      (cdr head)
      (remove head target)))