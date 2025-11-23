(define (maximum-product nums k)
  (let loop ([nums nums] [k k])
    (if (zero? k)
        (modulo (apply * nums) 1000000007)
        (let* ([min-val (apply min nums)]
               [index (index-of nums min-val)]
               [new-nums (list-update nums index (lambda (x) (+ x 1)))])
          (loop new-nums (- k 1))))))