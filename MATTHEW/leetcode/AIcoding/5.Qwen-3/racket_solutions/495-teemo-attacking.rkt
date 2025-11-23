(define (teemo-attacking time-series damage)
  (define (helper i res)
    (if (>= i (length time-series))
        res
        (let* ((start (list-ref time-series i))
               (end (+ start damage))
               (next-start (if (< (+ i 1) (length time-series)) (list-ref time-series (+ i 1)) #inf)))
          (helper (+ i 1) (+ res (min (- end start) (- next-start start)))))))
  (helper 0 0))