(define (number-of-good-paths vals edges)
  (define n (vector-length vals))
  (define (make-adj n)
    (build-vector n (lambda (i) (list))))
  (define adj (make-adj n))

  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define sorted-nodes-list
    (sort (build-list n (lambda (i) (list (vector-ref vals i) i)))
          (lambda (a b) (< (car a) (car b)))))
  (define sorted-nodes (list->vector sorted-nodes-list))

  (define parent (build-vector n (lambda (i) i)))
  (define ranks (build-vector n (lambda (i) 0)))
  (define val-counts (build-vector n (lambda (i) 1)))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (begin
          (vector-set! parent i (find (vector-ref parent i)))
          (vector-ref parent i))))

  (define current-ans n)

  (define (union-and-update u-idx v-idx)
    (define root-u (find u-idx))
    (define root-v (find v-idx))

    (unless (= root-u root-v)
      (let* ((val-root-u (vector-ref vals root-u))
             (val-root-v (vector-ref vals root-v)))

        (when (= val-root-u val-root-v)
          (set! current-ans (+ current-ans (* (vector-ref val-counts root-u) (vector-ref val-counts root-v)))))

        (cond
          ((> (vector-ref ranks root-u) (vector-ref ranks root-v))
           (vector-set! parent root-v root-u)
           (when (= val-root-u val-root-v)
             (vector-set! val-counts root-u (+ (vector-ref val-counts root-u) (vector-ref val-counts root-v)))))
          ((< (vector-ref ranks root-u) (vector-ref ranks root-v))
           (vector-set! parent root-u root-v)
           (when (= val-root-u val-root-v)
             (vector-set! val-counts root-v (+ (vector-ref val-counts root-u) (vector-ref val-counts root-v)))))
          (else
           (vector-set! parent root-v root-u)
           (vector-set! ranks root-u (+ (vector-ref ranks root-u) 1))
           (when (= val-root-u val-root-v)
             (vector-set! val-counts root-u (+ (vector-ref val-counts root-u) (vector-ref val-counts root-v))))))))

  (let loop ((current-group-start-idx 0))
    (when (< current-group-start-idx n)
      (let* ((u-val (car (vector-ref sorted-nodes current-group-start-idx)))
             (group-end-idx
              (let find-end ((k current-group-start-idx))
                (if (and (< k n) (= (car (vector-ref sorted-nodes k)) u-val))
                    (find-end (+ k 1))
                    k))))

        (for ((i (in-range current-group-start-idx group-end-idx)))
          (define u-idx (cadr (vector-ref sorted-nodes i)))
          (for-each (lambda (v-idx)
                      (when (<= (vector-ref vals v-idx) u-val)
                        (union-and-update u-idx v-idx)))
                    (vector-ref adj u-idx)))

        (loop group-end-idx))))

  current-ans)