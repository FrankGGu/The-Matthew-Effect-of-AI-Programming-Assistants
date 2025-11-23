(define (distribute-elements-into-two-arrays nums)
  (define a '())
  (define b '())
  (define (add-to-a? x)
    (cond
      [(empty? b) #t]
      [else (>= x (car b))]))
  (define (add-to-b? x)
    (cond
      [(empty? a) #t]
      [else (>= x (car a))]))
  (for ([x (in-list nums)])
    (cond
      [(and (add-to-a? x) (add-to-b? x))
       (cond
         [(empty? a) (set! a (cons x a))]
         [(empty? b) (set! b (cons x b))]
         [else (if (>= (car a) (car b))
                   (set! a (cons x a))
                   (set! b (cons x b)))]
         )]
      [(add-to-a? x) (set! a (cons x a))]
      [(add-to-b? x) (set! b (cons x b))]
      [else (void)]))
  (values (reverse a) (reverse b)))