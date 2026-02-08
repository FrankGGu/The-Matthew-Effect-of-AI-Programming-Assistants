#lang racket

(define (top-k-frequent nums k)
  (define freq-map (make-hash))

  (for-each (lambda (num)
              (hash-set! freq-map num (+ (hash-ref freq-map num 0) 1)))
            nums)

  (define freq-list (hash->list freq-map))

  (define sorted-freq-list
    (sort freq-list (lambda (a b)
                      (> (cdr a) (cdr b)))))

  (define top-k-pairs (take sorted-freq-list k))

  (map car top-k-pairs))