(define (minOperations nums)
  (define counts (make-hash))
  (for ([num nums])
    (hash-set! counts num (+ 1 (hash-ref counts num 0))))
  (define sorted-keys (sort (hash-keys counts) <))
  (define (helper keys ops)
    (if (null? keys)
      ops
      (let ([key (car keys)])
        (helper (cdr keys) (+ ops (hash-ref counts key)))))) 
  (helper sorted-keys 0))

(minOperations '(1 2 3 4 5))