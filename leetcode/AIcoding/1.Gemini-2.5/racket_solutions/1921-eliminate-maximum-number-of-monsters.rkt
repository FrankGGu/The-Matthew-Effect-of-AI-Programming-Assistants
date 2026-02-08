(define (eliminate-maximum dist speed)
  (define arrival-times
    (map (lambda (d s) (ceiling (/ d s))) dist speed))

  (define sorted-arrival-times
    (sort arrival-times <))

  (let loop ((times sorted-arrival-times)
             (eliminated-count 0)
             (current-time 0))
    (if (null? times)
        eliminated-count
        (let ((monster-arrival-time (car times)))
          (if (<= monster-arrival-time current-time)
              eliminated-count
              (loop (cdr times)
                    (add1 eliminated-count)
                    (add1 current-time)))))))