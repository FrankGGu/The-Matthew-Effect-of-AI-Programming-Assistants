#lang racket

(define (num-ways n edges)
  (define graph (make-hash))
  (for-each
   (lambda (e)
     (let ([u (car e)] [v (cadr e)])
       (hash-update! graph u (λ (lst) (cons v lst)) '())
       (hash-update! graph v (λ (lst) (cons u lst)) '())))
  (define visited (make-hash))
  (define (dfs u parent)
    (let ([count 1])
      (for-each
       (lambda (v)
         (when (not (= v parent))
           (set! count (* count (dfs v u)))))
      count))
  (if (= n 1) 1 (dfs 1 -1)))