(define (can-complete-circuit gas cost)
  (let* ([n (length gas)]
         [total-surplus (foldl + 0 (map - gas cost))]
         [current-surplus (lambda (start)
                            (let loop ([i start] [surplus 0])
                              (cond
                                [(equal? i (+ start n)) surplus]
                                [else (let ([idx (modulo i n)])
                                        (let ([new-surplus (+ surplus (- (list-ref gas idx) (list-ref cost idx)))])
                                          (if (< new-surplus 0) #f
                                              (loop (+ i 1) new-surplus)))))]))])
    (if (< total-surplus 0) -1
        (let loop ([start 0])
          (cond
            [(equal? start n) -1]
            [(not (equal? (current-surplus start) #f)) start]
            [else (loop (+ start 1))])))))