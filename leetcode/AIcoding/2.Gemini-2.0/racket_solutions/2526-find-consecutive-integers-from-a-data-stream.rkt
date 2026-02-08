(define stream-checker%
  (class object%
    (inherit)
    (init sequence k)
    (define sequence sequence)
    (define k k)
    (define stream '())
    (define/public (has-k)
      (if (< (length stream) k)
          #f
          (let loop ([i 0])
            (cond
              [(>= i k) #t]
              [(= (list-ref stream (- (length stream) 1 i)) sequence) (loop (+ i 1))]
              [else #f]))))
    (define/public (next value)
      (set! stream (append stream (list value)))
      (has-k))))