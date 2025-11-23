(define n 0)
(define adj (make-vector 0 '()))
(define nums (make-vector 0 0))

(define subtree-xor (make-vector 0 0))
(define tin (make-vector 0 0))
(define tout (make-vector 0 0))
(define edges-list '()) ; Stores (list u v) for parent u, child v in DFS tree
(define timer 0)

(define (dfs u p)
  (set! timer (+ timer 1))
  (vector-set! tin u timer)
  (let loop ((current-node-xor (vector-ref nums u))
             (neighbors (vector-ref adj u))
             (children-xor 0))
    (if (null? neighbors)
        (begin
          (vector-set! subtree-xor u (bitwise-xor current-node-xor children-xor))
          (set! timer (+ timer 1))
          (vector-set! tout u timer)
          (bitwise-xor current-node-xor children-xor))
        (let* ((v (car neighbors))
               (rest (cdr neighbors)))
          (if (= v p)
              (loop current-node-xor rest children-xor)
              (begin
                (set! edges-list (cons (list u v) edges-list))
                (loop current-node-xor rest (bitwise-xor children-xor (dfs v u)))))))))

(define (minimum-score-after-removals-on-a-tree nums-arg edges-arg)
  (set! n (vector-length nums-arg))
  (set! nums nums-arg)
  (set! adj (make-vector n '()))
  (set! subtree-xor (make-vector n 0))
  (set! tin (make-vector n 0))
  (set! tout (make-vector n 0))
  (set! edges-list '())
  (set! timer 0)

  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges-arg)

  (define total-xor (foldl bitwise-xor 0 (vector->list nums)))

  (dfs 0 -1)

  (define min-score (expt 2 30))

  (let* ((num-edges (length edges-list))
         (edges-vec (list->vector edges-list)))
    (for ((i (in-range num-edges)))
      (let* ((edge1 (vector-ref edges-vec i))
             (v1 (cadr edge1))
             (s1 (vector-ref subtree-xor v1)))
        (for ((j (in-range (+ i 1) num-edges)))
          (let* ((edge2 (vector-ref edges-vec j))
                 (v2 (cadr edge2))
                 (s2 (vector-ref subtree-xor v2)))

            (define x 0)
            (define y 0)
            (define z 0)

            (define v1-is-ancestor-of-v2?
              (and (<= (vector-ref tin v1) (vector-ref tin v2))
                   (>= (vector-ref tout v1) (vector-ref tout v2))))

            (define v2-is-ancestor-of-v1?
              (and (<= (vector-ref tin v2) (vector-ref tin v1))
                   (>= (vector-ref tout v2) (vector-ref tout v1))))

            (cond
              [v1-is-ancestor-of-v2?
               (set! x s2)
               (set! y (bitwise-xor s1 s2))
               (set! z (bitwise-xor total-xor s1))]
              [v2-is-ancestor-of-v1?
               (set! x s1)
               (set! y (bitwise-xor s2 s1))
               (set! z (bitwise-xor total-xor s2))]
              [else
               (set! x s1)
               (set! y s2)
               (set! z (bitwise-xor total-xor s1 s2))])

            (define current-max (max x y z))
            (define current-min (min x y z))
            (set! min-score (min min-score (- current-max current-min))))))))
  min-score)