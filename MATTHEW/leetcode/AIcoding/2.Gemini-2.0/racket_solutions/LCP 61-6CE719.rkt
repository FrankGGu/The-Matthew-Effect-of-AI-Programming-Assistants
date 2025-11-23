(define (temperature-trend temperatures1 temperatures2)
  (let loop ([t1 temperatures1] [t2 temperatures2] [trend 0] [count 0])
    (cond
      [(or (null? t1) (null? t2)) count]
      [(> (car t2) (car t1))
       (if (and (not (null? (cdr t1))) (not (null? (cdr t2))) (> (cadr t2) (cadr t1)))
           (loop (cdr t1) (cdr t2) (+ trend 1) (+ count 1))
           (loop (cdr t1) (cdr t2) 0 count))]
      [(< (car t2) (car t1))
       (if (and (not (null? (cdr t1))) (not (null? (cdr t2))) (< (cadr t2) (cadr t1)))
           (loop (cdr t1) (cdr t2) (+ trend 1) (+ count 1))
           (loop (cdr t1) (cdr t2) 0 count))]
      [else
       (if (and (not (null? (cdr t1))) (not (null? (cdr t2))) (= (cadr t2) (cadr t1)))
           (loop (cdr t1) (cdr t2) (+ trend 1) (+ count 1))
           (loop (cdr t1) (cdr t2) 0 count))])))