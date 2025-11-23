#lang racket

(define (find-minimum-diameter-after-merging-two-trees n1 edges1 n2 edges2)

  (define (solve-tree n edges)
    (if (= n 0) (values 0 0)
        (if (= n 1) (values 0 0)
            (let* ((adj (make-vector n (list)))
                   (down-depth (make-vector n 0))
                   (up-depth (make-vector n 0))
                   (max-child-depth1 (make-vector n 0))
                   (max-child-depth2 (make-vector n 0))
                   (current-diameter 0))

              (for-each
               (lambda (edge)
                 (let ((u (car edge)) (v (cadr edge)))
                   (vector-set! adj u (cons v (vector-ref adj u)))
                   (vector-set! adj v (cons u (vector-ref adj v)))))
               edges)

              (define (dfs-down u p)
                (let ((children (filter (lambda (v) (not (= v p))) (vector-ref adj u))))
                  (for-each
                   (lambda (v)
                     (dfs-down v u)
                     (let ((child-path-len (+ 1 (vector-ref down-depth v))))
                       (when (> child-path-len (vector-ref max-child-depth1 u))
                         (set! (vector-ref max-child-depth2 u) (vector-ref max-child-depth1 u))
                         (set! (vector-ref max-child-depth1 u) child-path-len))
                       (when (and (< child-path-len (vector-ref max-child-depth1 u))
                                  (> child-path-len (vector-ref max-child-depth2 u)))
                         (set! (vector-ref max-child-depth2 u) child-path-len))))
                   children)
                  (set! (vector-ref down-depth u) (vector-ref max-child-depth1 u))
                  (set! current-diameter (max current-diameter
                                              (+ (vector-ref max-child-depth1 u)
                                                 (vector-ref max-child-depth2 u))))))

              (define (dfs-up u p)
                (let ((children (filter (lambda (v) (not (= v p))) (vector-ref adj u))))
                  (for-each
                   (lambda (v)
                     (let* ((path-from-parent-up (+ 1 (vector-ref up-depth u)))
                            (path-from-parent-down-other-branch
                             (if (= (+ 1 (vector-ref down-depth v)) (vector-ref max-child-depth1 u))
                                 (+ 1 (vector-ref max-child-depth2 u))
                                 (+ 1 (vector-ref max-child-depth1 u)))))
                       (set! (vector-ref up-depth v) (max path-from-parent-up path-from-parent-down-other-branch))
                       (dfs-up v u)))
                   children)))

              (set! (vector-ref up-depth 0) 0)
              (dfs-down 0 -1)
              (dfs-up 0 -1)

              (let ((min-eccentricity (expt 2 30)))
                (for ((i (in-range n)))
                  (let ((ecc (max (vector-ref down-depth i) (vector-ref up-depth i))))
                    (set! min-eccentricity (min min-eccentricity ecc))
                    (set! current-diameter (max current-diameter
                                                (+ (vector-ref down-depth i)
                                                   (vector-ref up-depth i))))))
                (values current-diameter min-eccentricity))))))

  (let-values (((diameter1 min-ecc1) (solve-tree n1 edges1))
               ((diameter2 min-ecc2) (solve-tree n2 edges2)))
    (max diameter1 diameter2 (+ min-ecc1 min-ecc2 1))))