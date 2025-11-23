(define (findPoisonedDuration timeSeries duration)
  (if (null? timeSeries)
      0
      (let loop ((times timeSeries)
                 (total 0)
                 (prev 0))
        (cond
          ((null? times) total)
          (else
           (let ((current (car times)))
             (loop (cdr times)
                   (+ total (min duration (- current prev)))
                   current)))))))

(findPoisonedDuration '(1 4 5) 2)