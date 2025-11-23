#lang racket

(define (max-strictly-increasing-cells matrix)
  (define m (vector-length matrix))
  (define n (vector-length (vector-ref matrix 0)))

  (define all-cells
    (for*/list ([r (in-range m)]
                [c (in-range n)])
      (list (vector-ref (vector-ref matrix r) c) r c)))

  (define sorted-cells (sort all-cells (lambda (a b) (< (car a) (car b)))))

  (define row-max-dp (make-vector m 0))
  (define col-max-dp (make-vector n 0))

  (define max-overall-len 0)

  (define current-idx 0)
  (define num-cells (* m n))

  (while (< current-idx num-cells)
    (define current-val (car (list-ref sorted-cells current-idx)))
    (define group-end-idx current-idx)
    (while (and (< group-end-idx num-cells)
                (= (car (list-ref sorted-cells group-end-idx)) current-val))
      (set! group-end-idx (+ group-end-idx 1)))

    (define updates '())
    (for ([i (in-range current-idx group-end-idx)])
      (define cell (list-ref sorted-cells i))
      (define r (cadr cell))
      (define c (caddr cell))

      (define len (max 1
                       (+ 1 (vector-ref row-max-dp r))
                       (+ 1 (vector-ref col-max-dp c))))

      (set! updates (cons (list r c len) updates)))

    (for ([update-item updates])
      (define r (car update-item))
      (define c (cadr update-item))
      (define len (caddr update-item))

      (vector-set! row-max-dp r (max (vector-ref row-max-dp r) len))
      (vector-set! col-max-dp c (max (vector-ref col-max-dp c) len))
      (set! max-overall-len (max max-overall-len len)))

    (set! current-idx group-end-idx))

  max-overall-len)