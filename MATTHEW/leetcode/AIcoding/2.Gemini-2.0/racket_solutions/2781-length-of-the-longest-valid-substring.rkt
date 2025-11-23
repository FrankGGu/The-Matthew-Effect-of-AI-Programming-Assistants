(define (longest-valid-substring word forbidden)
  (define (valid-substring? s)
    (not (ormap (lambda (f) (string-contains? s f)) forbidden)))

  (define (helper start end)
    (cond
      [(>= start (string-length word)) 0]
      [(>= end (string-length word)) (helper (+ start 1) (+ start 1))]
      [else
       (let ([sub (substring word start end)])
         (if (valid-substring? sub)
             (max (- end start) (helper start (+ end 1)) (helper (+ start 1) (+ start 1)))
             (helper (+ start 1) (+ start 1))))]))

  (helper 0 1))