(define (maximum-swap num)
  (let* ([s (number->string num)]
         [n (string-length s)]
         [last-occurrence (make-vector 10 -1)])
    (for ([i (in-range n)])
      (string->number (substring s i (+ i 1)))
      (vector-set! last-occurrence (string->number (substring s i (+ i 1))) i))
    (let loop ([i 0])
      (cond
        [(>= i n) num]
        [else
         (let ([digit (string->number (substring s i (+ i 1)))])
           (let loop2 ([d 9])
             (cond
               [(< d digit) #f]
               [(>= d 0)
                (let ([last-index (vector-ref last-occurrence d)])
                  (cond
                    [(> last-index i)
                     (let ([new-s (string-copy s)])
                       (string-set! new-s i (string-ref s last-index))
                       (string-set! new-s last-index (string-ref s i))
                       (string->number new-s))
                     ]
                    [else (loop2 (- d 1))]
                    ))]
               [else (loop (+ i 1))]))]))])))