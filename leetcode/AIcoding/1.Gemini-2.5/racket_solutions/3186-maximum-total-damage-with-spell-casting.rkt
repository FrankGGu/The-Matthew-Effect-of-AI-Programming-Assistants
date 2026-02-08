#lang racket

(define (maximum-total-damage-with-spell-casting damage)
  (let* ([max-d 0]
         [damage-counts (make-hash)])

    (for-each (lambda (d)
                (set! max-d (max max-d d))
                (hash-update! damage-counts d add1 0))
              damage)

    (define total-damage-for-value (make-vector (+ max-d 1) 0))
    (hash-for-each (lambda (d count)
                     (vector-set! total-damage-for-value d (* d count)))
                   damage-counts)

    (define dp (make-vector (+ max-d 1) 0))

    (when (> (+ max-d 1) 0)
      (vector-set! dp 0 (vector-ref total-damage-for-value 0)))

    (when (> (+ max-d 1) 1)
      (vector-set! dp 1 (max (vector-ref dp 0) (vector-ref total-damage-for-value 1))))

    (for ([i (in-range 2 (+ max-d 1))])
      (vector-set! dp i
                   (max (vector-ref dp (- i 1))
                        (+ (vector-ref dp (- i 2))
                           (vector-ref total-damage-for-value i)))))

    (vector-ref dp max-d)))