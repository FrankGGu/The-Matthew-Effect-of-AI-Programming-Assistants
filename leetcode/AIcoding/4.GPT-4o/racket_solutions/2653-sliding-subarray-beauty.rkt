(define (get-subarray-beauty nums k x)
  (define (count-less-or-equal lst val)
    (length (filter (lambda (y) (<= y val)) lst)))

  (define (beauty-of-subarray sub)
    (if (< (length sub) k)
        0
        (- (count-less-or-equal sub x) (count-less-or-equal sub (- x 1)))))

  (define (sliding-window lst k)
    (if (< (length lst) k)
        '()
        (cons (beauty-of-subarray (take lst k))
              (sliding-window (cdr lst) k))))

  (sliding-window nums k))

(define (get-beauty nums k x)
  (define beauties (get-subarray-beauty nums k x))
  (map (lambda (b) (if (= b 0) 0 b)) beauties))

(get-beauty nums k x)