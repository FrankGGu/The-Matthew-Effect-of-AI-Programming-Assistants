#lang racket

(define (top-k-frequent-words words k)
  (define freq
    (for/fold ([acc '()])
              ([word words])
      (let ([entry (assoc word acc)])
        (if entry
            (cons (cons word (+ 1 (cdr entry))) (remove entry acc))
            (cons (cons word 1) acc)))))
  (define sorted
    (sort freq (lambda (a b)
                 (or (< (cdr b) (cdr a))
                     (and (= (cdr a) (cdr b)) (string<? (car a) (car b)))))))
  (take (map car sorted) k))