#lang racket

(define-struct node (val next) #:mutable)

(define (create-linked-list)
  #f)

(define (get-index lst index)
  (define (iter current i)
    (if (or (not current) (> i index))
        -1
        (if (= i index)
            (node-val current)
            (iter (node-next current) (+ i 1)))))
  (iter lst 0))

(define (add-at-head lst val)
  (define new-node (make-node val lst))
  new-node)

(define (add-at-tail lst val)
  (define (iter current)
    (if (not (node-next current))
        (set-node-next! current (make-node val #f))
        (iter (node-next current))))
  (if (not lst)
      (make-node val #f)
      (begin (iter lst) lst)))

(define (add-at-index lst index val)
  (if (<= index 0)
      (add-at-head lst val)
      (let ((current lst))
        (define (iter i)
          (if (or (not current) (= i (- index 1)))
              (begin (set-node-next! current (make-node val (node-next current))) lst)
              (begin (set! current (node-next current)) (iter (+ i 1)))))
        (iter 0))))

(define (delete-at-index lst index)
  (if (<= index 0)
      (if (not lst)
          #f
          (node-next lst))
      (let ((current lst))
        (define (iter i)
          (if (or (not current) (= i (- index 1)))
              (set-node-next! current (node-next (node-next current)))
              (begin (set! current (node-next current)) (iter (+ i 1)))))
        (iter 0)
        lst)))

(define (get-list lst)
  (define (iter current res)
    (if (not current)
        res
        (iter (node-next current) (append res (list (node-val current))))))
  (iter lst '()))