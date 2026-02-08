#lang racket

(require racket/class)

(define TreeAncestor%
  (class object%
    (init-field n parent)
    (field [up #f] [max-log #f])

    (define/public (getKthAncestor node k)
      (define current-node node)
      (for ([j (in-range (- max-log 1) -1 -1)])
        (when (not (= current-node -1))
          (when (not (= (bitwise-and (arithmetic-shift k (- j)) 1) 0))
            (set! current-node (vector-ref (vector-ref up current-node) j)))))
      current-node)

    (super-new)

    (set! max-log (if (= n 1) 1 (integer-length (- n 1))))
    (set! up (make-vector n (make-vector max-log -1)))

    (for ([i (in-range n)])
      (vector-set! (vector-ref up i) 0 (vector-ref parent i)))

    (for ([j (in-range 1 max-log)])
      (for ([i (in-range n)])
        (define prev-ancestor (vector-ref (vector-ref up i) (- j 1)))
        (when (not (= prev-ancestor -1))
          (vector-set! (vector-ref (vector-ref up i) j)
                       (vector-ref (vector-ref up prev-ancestor) (- j 1))))))))

(define (TreeAncestor n parent)
  (new TreeAncestor% [n n] [parent parent]))