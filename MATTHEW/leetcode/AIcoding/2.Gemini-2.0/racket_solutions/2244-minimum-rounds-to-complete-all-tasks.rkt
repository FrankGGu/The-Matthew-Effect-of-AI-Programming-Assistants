(define (minimumRounds tasks)
  (let* ((freqs (hash))
         (count (length tasks)))
    (for ([task tasks])
      (hash-update! freqs task (lambda (v) (+ v 1)) 1))
    (let loop ([counts (hash-values freqs)]
               [rounds 0])
      (cond
        [(null? counts) rounds]
        [else
         (let ([c (car counts)])
           (cond
             [(= c 1) -1]
             [(= (modulo c 3) 0)
              (loop (cdr counts) (+ rounds (/ c 3)))]
             [(= (modulo c 3) 1)
              (loop (cdr counts) (+ rounds (+ 1 (/ (- c 4) 3))))]
             [(= (modulo c 3) 2)
              (loop (cdr counts) (+ rounds (+ 1 (/ (- c 2) 3))))]))])))))