(define (rotating-the-box box)
  (let* ([rows (length box)]
         [cols (length (car box))]
         [rotated-box (make-vector cols (make-vector rows #\.))])
    (for ([r (in-range rows)])
      (for ([c (in-range cols)])
        (vector-set! (vector-ref rotated-box c) (- rows 1 r) (list-ref (list-ref box r) c))))
    (for ([c (in-range cols)])
      (let loop ([r 0] [stones 0])
        (cond
          [(= r rows) (void)]
          [(equal? (vector-ref (vector-ref rotated-box c) r) #'* ) (loop (+ r 1) 0)]
          [(equal? (vector-ref (vector-ref rotated-box c) r) #'.' ) (loop (+ r 1) stones)]
          [(equal? (vector-ref (vector-ref rotated-box c) r) #\# )
           (vector-set! (vector-ref rotated-box c) r #\.)
           (let find-empty ([idx (- r 1)])
             (cond
               [(= idx -1)
                (vector-set! (vector-ref rotated-box c) 0 #\#)]
               [(equal? (vector-ref (vector-ref rotated-box c) idx) #\.)
                (vector-set! (vector-ref rotated-box c) idx #\#)]
               [else
                (find-empty (- idx 1))]))
           (loop (+ r 1) 0)]
          [else (error "Invalid character in box")])))
    (map (lambda (row) (vector->list row)) (vector->list rotated-box))))