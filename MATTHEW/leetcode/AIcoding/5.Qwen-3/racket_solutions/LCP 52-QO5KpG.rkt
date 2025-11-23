#lang racket

(define (lowest-common-ancestor root p q)
  (cond [(> (car p) (car root)) (lowest-common-ancestor (caddr root) p q)]
        [(< (car q) (car root)) (lowest-common-ancestor (cadr root) p q)]
        [else root]))

(define (get-path root target)
  (if (null? root)
      '()
      (let ([val (car root)])
        (if (= val (car target))
            (list root)
            (append (list root)
                    (if (> (car target) val)
                        (get-path (caddr root) target)
                        (get-path (cadr root) target)))))))

(define (color-segment tree start end)
  (define (dfs node path)
    (if (null? node)
        '()
        (let ([new-path (append path (list node))])
          (if (and (<= (car start) (car node) (car end)))
              (append (list node) (dfs (cadr node) new-path) (dfs (caddr node) new-path))
              (append (dfs (cadr node) new-path) (dfs (caddr node) new-path)))))
  (dfs tree '()))

(define (solve tree start end)
  (define lca (lowest-common-ancestor tree start end))
  (define path-to-lca (get-path tree lca))
  (define path-to-start (reverse (take (get-path tree start) (length (get-path tree lca)))))
  (define path-to-end (reverse (take (get-path tree end) (length (get-path tree lca)))))
  (define all-nodes (append path-to-start (cdr path-to-lca) (cdr path-to-end)))
  (map car all-nodes))