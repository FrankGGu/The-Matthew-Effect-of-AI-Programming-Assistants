(define (hardest-worker n logs)
  (define max-time (apply max (map (lambda (log) (cdr log)) logs)))
  (define longest-worker 
    (apply max 
           (map (lambda (log) 
                  (if (= (cdr log) max-time) 
                      (car log) 
                      -1)) 
                logs)))
  (if (= longest-worker -1)
      (apply max (map car logs))
      longest-worker))