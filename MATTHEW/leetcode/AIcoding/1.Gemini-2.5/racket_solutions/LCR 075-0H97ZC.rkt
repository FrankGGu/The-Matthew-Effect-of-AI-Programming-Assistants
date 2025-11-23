#lang racket

(define (relative-sort-array arr1 arr2)
  (define freq (make-vector 1001 0))

  (for-each (lambda (x)
              (vector-set! freq x (+ (vector-ref freq x) 1)))
            arr1)

  (define arr2-parts
    (for/list ([val arr2])
      (let ((count (vector-ref freq val)))
        (vector-set! freq val 0)
        (build-list count (lambda (i) val)))))

  (define result-arr2-flat (apply append arr2-parts))

  (define remaining-parts '())
  (for ((i (in-range 0 1001)))
    (let ((count (vector-ref freq i)))
      (when (> count 0)
        (set! remaining-parts (cons (build-list count (lambda (j) i)) remaining-parts)))))

  (define result-remaining-flat (apply append (reverse remaining-parts)))

  (append result-arr2-flat result-remaining-flat))