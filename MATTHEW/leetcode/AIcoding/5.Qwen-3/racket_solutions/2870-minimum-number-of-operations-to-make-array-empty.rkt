(define (min-operations nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (let loop ((res 0))
    (if (null? (hash->list freq))
        res
        (let* ((counts (map (lambda (x) (hash-ref freq x)) (hash-keys freq)))
               (min-count (apply min counts)))
          (if (= min-count 0)
              res
              (begin
                (for-each (lambda (k) (hash-set! freq k (- (hash-ref freq k) min-count))) (hash-keys freq))
                (loop (+ res min-count))))))))