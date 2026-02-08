(define (total-fruit fruits k)
  (define (helper fruits start end count basket)
    (cond
      [(>= end (length fruits)) count]
      [else
       (let ([fruit (list-ref fruits end)])
         (cond
           [(hash-has-key? basket fruit)
            (hash-update! basket fruit add1 0)
            (helper fruits start (+ 1 end) (+ 1 count) basket)]
           [(< (hash-count basket) k)
            (hash-set! basket fruit 1)
            (helper fruits start (+ 1 end) (+ 1 count) basket)]
           [else
            (let loop ([i start])
              (if (= (hash-ref basket (list-ref fruits i) 0) 1)
                  (begin
                    (hash-remove! basket (list-ref fruits i))
                    (hash-set! basket fruit 1)
                    (helper fruits (+ 1 i) (+ 1 end) (+ 1 count) basket))
                  (begin
                    (hash-update! basket (list-ref fruits i) sub1 0)
                    (loop (+ 1 i)))))]))]))

  (let ([max-count 0])
    (for ([i (in-range (length fruits))])
      (let ([current-count (helper fruits i i 0 (make-hash))])
        (set! max-count (max max-count current-count))))
    max-count))