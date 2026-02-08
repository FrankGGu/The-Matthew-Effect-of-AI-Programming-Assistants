(define (num-ways s)
  (define n (string-length s))
  (define ones (count (lambda (c) (equal? c #\1)) (string->list s)))

  (cond
    [(= ones 0) (modulo (* (- n 1) (- n 2) (/ 1 2)) 1000000007)]
    [(!= (modulo ones 3) 0) 0]
    [else
     (define target (/ ones 3))
     (define (count-ways start)
       (let loop ([i start] [count 0] [ones-count 0])
         (cond
           [(= i n) count]
           [(= ones-count target) (add1 count)]
           [else (loop (add1 i) count (if (equal? (string-ref s i) #\1) (add1 ones-count) ones-count))])))
     (define first-split-ways (count-ways 0))
     (define second-split-start (let loop ([i 0] [ones-count 0])
                                   (cond
                                     [(= i n) n]
                                     [(= ones-count target) i]
                                     [else (loop (add1 i) (if (equal? (string-ref s i) #\1) (add1 ones-count) ones-count))])))
     (define second-split-ways (count-ways second-split-start))
     (modulo (* first-split-ways second-split-ways) 1000000007)]))