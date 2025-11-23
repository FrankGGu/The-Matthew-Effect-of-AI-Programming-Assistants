(define (decompress-rl-encoded-list nums)
  (let loop ([nums nums] [result '()])
    (cond
      [(empty? nums) (reverse result)]
      [else (let ([freq (car nums)] [val (cadr nums)])
              (loop (cddr nums) (append (make-list freq val) result)))])))