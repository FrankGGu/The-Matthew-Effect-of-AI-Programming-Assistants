(define (get-trend t1 t2)
  (cond
    ((> t2 t1) 1)
    ((< t2 t1) -1)
    (else 0)))

(define (temperature-trend temperatureA temperatureB)
  (let ((n (length temperatureA)))
    (for/sum ((i (in-range (- n 1))))
      (let* ((trendA (get-trend (list-ref temperatureA i) (list-ref temperatureA (+ i 1))))
             (trendB (get-trend (list-ref temperatureB i) (list-ref temperatureB (+ i 1)))))
        (if (= trendA trendB) 1 0)))))