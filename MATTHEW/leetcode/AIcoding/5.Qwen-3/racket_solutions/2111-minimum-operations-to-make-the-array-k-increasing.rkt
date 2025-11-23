#lang racket

(define (min-operations nums k)
  (define (lis seq)
    (define dp (make-vector (length seq) 1))
    (for ([i (in-range (length seq))])
      (for ([j (in-range i)])
        (when (<= (list-ref seq j) (list-ref seq i))
          (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1)))))
    (apply max (vector->list dp)))

  (define len (length nums))
  (define result 0)
  (for ([i (in-range k)])
    (define subseq (for/list ([j (in-range i len k)]) (list-ref nums j)))
    (set! result (+ result (- (length subseq) (lis subseq)))))
  result)