(define (duplicate-xor nums)
  (let ([counts (make-hash)])
    (for-each (lambda (num)
                (hash-set! counts num (+ (hash-ref counts num 0) 1)))
              nums)
    (let loop ([result 0]
               [keys (hash-keys counts)])
      (if (empty? keys)
          result
          (let ([current-key (car keys)])
            (if (= (hash-ref counts current-key) 2)
                (loop (bitwise-xor result current-key) (cdr keys))
                (loop result (cdr keys))))))))