(define (magicalString n)
  (cond
    [(<= n 0) 0]
    [(= n 1) 1]
    [else
     (let* ([s (make-vector n 0)]
            [i 2]
            [j 1]
            [head 2]
            [count 1])
       (vector-set! s 0 1)
       (vector-set! s 1 2)
       (let loop ()
         (cond
           [(>= i n) count]
           [else
            (let ([num (vector-ref s j)])
              (for ([k num])
                (cond
                  [(< i n)
                   (vector-set! s i (if (= (vector-ref s (sub1 i)) 1) 2 1))
                   (if (= (vector-ref s i) 1) (set! count (add1 count)))
                   (set! i (add1 i))
                   ]
                  [else (void)]))
              (set! j (add1 j))
              (loop)))))])))