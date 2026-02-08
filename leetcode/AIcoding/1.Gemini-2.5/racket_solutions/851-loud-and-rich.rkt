(define (loudAndRich quiet richer)
  (define N (length quiet))

  (define quiet-vec (list->vector quiet))

  (define ans (make-vector N -1))

  (define rev-adj (make-vector N '()))

  (for-each (lambda (pair)
              (define richer-person (car pair))
              (define poorer-person (cadr pair))
              (vector-set! rev-adj poorer-person
                           (cons richer-person (vector-ref rev-adj poorer-person))))
            richer)

  (define (dfs u)
    (if (not (= (vector-ref ans u) -1))
        (vector-ref ans u)
        (begin
          (define min-quiet-idx u)

          (for-each (lambda (v)
                      (define candidate-idx (dfs v))
                      (when (< (vector-ref quiet-vec candidate-idx)
                               (vector-ref quiet-vec min-quiet-idx))
                        (set! min-quiet-idx candidate-idx)))
                    (vector-ref rev-adj u))

          (vector-set! ans u min-quiet-idx)
          min-quiet-idx)))

  (define (range n)
    (build-list n (lambda (i) i)))

  (for-each (lambda (i) (dfs i)) (range N))

  (vector->list ans))