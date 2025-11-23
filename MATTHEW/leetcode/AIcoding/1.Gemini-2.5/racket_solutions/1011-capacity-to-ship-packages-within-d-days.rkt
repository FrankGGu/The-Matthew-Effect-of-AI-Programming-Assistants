(define (ship-within-days packages d)

  (define (can-ship-within-days? current-capacity)
    (let loop ((pkgs packages)
               (days 1)
               (current-weight 0))
      (cond
        ((null? pkgs)
         (<= days d))
        (else
         (let ((package (car pkgs)))
           (if (> (+ current-weight package) current-capacity)
               ;; Start a new day
               (loop (cdr pkgs) (+ days 1) package)
               ;; Add to current day
               (loop (cdr pkgs) days (+ current-weight package))))))))

  (let* ((min-capacity (apply max packages))
         (max-capacity (apply + packages)))
    (let binary-search ((low min-capacity)
                        (high max-capacity)
                        (ans max-capacity))
      (if (> low high)
          ans
          (let ((mid (+ low (quotient (- high low) 2))))
            (if (can-ship-within-days? mid)
                ;; mid capacity is possible, try for a smaller one
                (binary-search low (- mid 1) mid)
                ;; mid capacity is not enough, need more
                (binary-search (+ mid 1) high ans)))))))