(define (restore-ip-addresses s)
  (define n (string-length s))
  (define result '())

  (define (is-valid? str)
    (and (not (and (> (string-length str) 1) (equal? (string-ref str 0) #\0)))
         (<= (string->number str) 255)))

  (define (backtrack index dots current-ip)
    (cond
      [(= dots 4)
       (if (= index n)
           (set! result (cons (string-join current-ip ".") result))
           #f)]
      [else
       (for ([i (in-range 1 (min (+ index 4) (+ n 1)))])
         (define segment (substring s index i))
         (if (is-valid? segment)
             (backtrack i (+ dots 1) (append current-ip (list segment)))))]))

  (backtrack 0 0 '())
  result)