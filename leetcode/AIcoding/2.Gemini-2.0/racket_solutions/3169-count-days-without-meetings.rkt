(define (count-days-without-meetings meetings duration)
  (let* ((n (length meetings))
         (busy-days (make-vector duration #f)))
    (for ([meeting meetings])
      (let ([start (car meeting)]
            [end (cdr meeting)])
        (for ([i (range start end)])
          (vector-set! busy-days i #t))))
    (let loop ([i 0]
               [count 0])
      (if (= i duration)
          count
          (loop (+ i 1)
                (if (vector-ref busy-days i)
                    count
                    (+ count 1)))))))