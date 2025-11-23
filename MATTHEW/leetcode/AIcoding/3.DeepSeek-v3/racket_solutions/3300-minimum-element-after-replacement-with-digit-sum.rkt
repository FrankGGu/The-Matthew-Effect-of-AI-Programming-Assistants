(define (minimum-array-sum nums)
  (let loop ([nums nums] [changed #f])
    (if (not changed)
        (let* ([min-val (apply min nums)]
               [max-val (apply max nums)]
               [max-idx (index-of nums max-val)])
          (if (= max-val min-val)
              (apply + nums)
              (let* ([digits (string->list (number->string max-val))]
                     [sum (apply + (map (lambda (c) (- (char->integer c) 48)) digits))]
                     [new-nums (list-set nums max-idx sum)])
                (loop new-nums #t))))
        (loop nums #f))))