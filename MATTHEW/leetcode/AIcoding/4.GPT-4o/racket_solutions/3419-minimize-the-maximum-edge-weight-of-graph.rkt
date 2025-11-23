#lang racket

(define (minimizeMax edges limit)
  (define (can_form_mst_with_max_weight(max_weight)
    (define (dfs node visited)
      (set! visited (set-add visited node))
      (for-each (lambda (edge)
                  (when (and (not (set-member? visited (car edge)))
                             (<= (cadr edge) max_weight))
                    (dfs (car edge) visited)))
                (filter (lambda (e) (or (equal? (car e) node) (equal? (cadr e) node)))
                        edges)))
      (set-member? visited limit))

  (define (binary_search left right)
    (if (<= left right)
      (let ((mid (quotient (+ left right) 2)))
        (if (can_form_mst_with_max_weight mid)
            (binary_search left (sub1 mid))
            (binary_search (add1 mid) right)))
      left))

  (define max_weight (apply max (map cadr edges)))
  (binary_search 0 max_weight))

(define (minimizeMaxWrapper edges limit)
  (minimizeMax edges limit))