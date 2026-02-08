(define (can-complete-training plan n)
  (define (check-training plan current-day)
    (if (>= current-day n)
        #t
        (let loop ((i 0))
          (cond
            ((= i (length plan)) #f)
            ((>= (list-ref plan i) (current-day + 1)) (loop (+ i 1)))
            (else (check-training plan (+ current-day 1)))))))
  (check-training plan 0))

(define (training-plan-iii plan n)
  (if (can-complete-training plan n)
      #t
      #f))