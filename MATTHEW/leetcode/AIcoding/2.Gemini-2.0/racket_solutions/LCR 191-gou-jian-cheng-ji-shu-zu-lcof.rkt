(define (按规则计算统计结果 operations values)
  (let loop ([ops operations] [vals values] [acc 0])
    (cond
      [(empty? ops) acc]
      [else
       (let ([op (car ops)] [val (car vals)])
         (cond
           [(equal? op 0) (loop (cdr ops) (cdr vals) (+ acc val))]
           [(equal? op 1) (loop (cdr ops) (cdr vals) (- acc val))]
           [(equal? op 2) (loop (cdr ops) (cdr vals) (* acc val))]
           [else (loop (cdr ops) (cdr vals) (/ acc val))]))])))