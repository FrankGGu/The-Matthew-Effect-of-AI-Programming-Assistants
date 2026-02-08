#lang racket
(require data/rbtree)

(define intervals-state (box (cons (rbt-empty <) 0)))

(define (add left right)
  (let* ((current-state (unbox intervals-state))
         (current-tree (car current-state))
         (current-total-count (cdr current-state))
         (new-L left)
         (new-R right)
         (removed-length 0))

    (define-values (tree-before-L tree-at-or-after-L) (rbt-split current-tree new-L))

    (define prev-s (rbt-max-key tree-before-L))
    (when prev-s
      (define prev-e (rbt-ref tree-before-L prev-s))
      (when (>= prev-e (- new-L 1))
        (set! new-L (min new-L prev-s))
        (set! new-R (max new-R prev-e))
        (set! tree-before-L (rbt-remove tree-before-L prev-s))
        (set! removed-length (+ removed-length (+ 1 (- prev-e prev-s))))))

    (define-values (tree-overlap-or-touch tree-after-R) (rbt-split tree-at-or-after-L (+ new-R 2)))

    (rbt-for-each (lambda (s e)
                    (set! new-L (min new-L s))
                    (set! new-R (max new-R e))
                    (set! removed-length (+ removed-length (+ 1 (- e s)))))
                  tree-overlap-or-touch)

    (define new-tree (rbt-add (rbt-join tree-before-L tree-after-R) new-L new-R))
    (define new-interval-length (+ 1 (- new-R new-L)))
    (define new-total-count (+ (- current-total-count removed-length) new-interval-length))

    (set-box! intervals-state (cons new-tree new-total-count))))

(define (count)
  (cdr (unbox intervals-state)))