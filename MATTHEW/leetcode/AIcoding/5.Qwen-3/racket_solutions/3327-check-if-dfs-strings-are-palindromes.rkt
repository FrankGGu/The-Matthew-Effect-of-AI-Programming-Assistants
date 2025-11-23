#lang racket

(define (is-palindrome s)
  (equal? s (reverse s)))

(define (dfs-tree root)
  (define (helper node res)
    (if (null? node)
        res
        (let ((val (car node))
              (left (cadr node))
              (right (caddr node)))
          (helper left (append res (list val)))
          (helper right (append res (list val))))))
  (helper root '()))

(define (check-dfs-strings-are-palindromes root)
  (define (dfs node res)
    (if (null? node)
        (is-palindrome res)
        (let ((val (car node))
              (left (cadr node))
              (right (caddr node)))
          (and (dfs left (append res (list val)))
               (dfs right (append res (list val)))))))
  (dfs root '()))