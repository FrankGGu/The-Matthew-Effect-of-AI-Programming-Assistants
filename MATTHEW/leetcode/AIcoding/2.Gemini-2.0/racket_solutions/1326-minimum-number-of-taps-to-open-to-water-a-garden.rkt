(define (min-taps n ranges)
  (define intervals (make-vector (+ n 1) 0))
  (for/list ([i (in-range (vector-length ranges))])
    (let* ([start (max 0 (- i (vector-ref ranges i)))]
           [end (min n (+ i (vector-ref ranges i)))])
      (vector-set! intervals start (max (vector-ref intervals start) end))))

  (define (solve current-reach taps)
    (cond
      [(>= current-reach n) taps]
      [(<= current-reach 0) -1]
      [else
       (let loop ([i current-reach] [max-reach current-reach])
         (cond
           [(< i 0) -1]
           [(<= (vector-ref intervals i) current-reach)
            (loop (- i 1) max-reach)]
           [else
            (let ([new-max-reach (max max-reach (vector-ref intervals i))])
              (if (= new-max-reach max-reach)
                  (loop (- i 1) max-reach)
                  (solve new-max-reach (+ taps 1))))]))]))

  (solve 0 0))