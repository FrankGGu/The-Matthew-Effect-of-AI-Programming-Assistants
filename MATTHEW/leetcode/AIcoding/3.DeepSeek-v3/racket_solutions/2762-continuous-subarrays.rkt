(define/contract (continuous-subarrays nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [res 0] [min-deque '()] [max-deque '()])
    (if (>= right (length nums))
        res
        (let* ([current (list-ref nums right)]
               [new-min-deque (let f ([dq min-deque])
                               (if (null? dq)
                                   (list current)
                                   (if (<= current (car dq))
                                       (cons current (f (cdr dq)))
                                   (cons (car dq) (f (cdr dq)))))]
               [new-max-deque (let f ([dq max-deque])
                               (if (null? dq)
                                   (list current)
                                   (if (>= current (car dq))
                                       (cons current (f (cdr dq)))
                                       (cons (car dq) (f (cdr dq)))))]
               [min-val (car new-min-deque)]
               [max-val (car new-max-deque)])
          (if (> (- max-val min-val) 2)
              (loop (add1 left) (add1 left) res '() '())
              (loop left (add1 right) (+ res (- right left -1)) new-min-deque new-max-deque))))))