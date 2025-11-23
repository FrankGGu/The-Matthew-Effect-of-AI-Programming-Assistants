(define (replace-non-coprime-numbers nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (lcm a b)
    (/ (* a b) (gcd a b)))

  (define (process lst acc)
    (cond
      [(empty? lst) (reverse acc)]
      [(empty? acc) (process (cdr lst) (list (car lst)))]
      [else
       (let* ([last-acc (car acc)]
              [current (car lst)])
         (if (= (gcd last-acc current) 1)
             (process (cdr lst) (cons current acc))
             (process (cdr lst) (cons (lcm last-acc current) (cdr acc)))))]))

  (process (reverse nums) '()))