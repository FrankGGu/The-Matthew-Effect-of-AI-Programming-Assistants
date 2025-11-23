(define (remove-nth-from-end head n)
  (define (list-length lst)
    (if (null? lst)
        0
        (+ 1 (list-length (cdr lst)))))

  (define len (list-length head))
  (define nth-from-start (- len n))

  (if (= nth-from-start 0)
      (cdr head)
      (let loop ([curr head] [count 1] [prev null])
        (cond
          [(null? curr) head]
          [(= count nth-from-start)
           (if (null? prev)
               (cdr head)
               (begin
                 (set-cdr! prev (cdr curr))
                 head))]
          [else (loop (cdr curr) (+ count 1) curr)]))))