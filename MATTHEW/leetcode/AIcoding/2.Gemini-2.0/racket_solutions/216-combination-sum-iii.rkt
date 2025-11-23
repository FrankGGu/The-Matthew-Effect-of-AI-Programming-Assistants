(define (combination-sum3 k n)
  (define (helper k n start current acc)
    (cond
      [(and (= k 0) (= n 0)) (cons (list->vector current) acc)]
      [(or (= k 0) (< n 0) (> start 9)) acc]
      [else
       (let* ([with-start (helper (- k 1) (- n start) (+ start 1) (cons start current) acc)]
              [without-start (helper k n (+ start 1) current acc)])
         (append with-start without-start))]))
  (helper k n 1 '() '()))