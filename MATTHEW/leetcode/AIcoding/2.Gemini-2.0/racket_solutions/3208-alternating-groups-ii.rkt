(define (alternating-groups s)
  (let loop ([s (string->list s)] [count 0] [group-size 0] [expected-group 0])
    (cond
      [(empty? s) count]
      [else
       (let ([current-group (char->integer (car s))])
         (cond
           [(= group-size 0)
            (loop (cdr s) (+ count 1) 1 current-group)]
           [(= current-group expected-group)
            (loop (cdr s) count (+ group-size 1) expected-group)]
           [else
            (loop (cdr s) (+ count 1) 1 current-group)]))])))
  )