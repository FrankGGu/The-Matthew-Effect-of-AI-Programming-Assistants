(define (minimum-time-to-brew-potions potions time k total-ingredients)
  (let* ([n (length potions)]
         [total-units-required (for/sum ([p potions]) p)])

    (when (> total-units-required total-ingredients)
      (if (= total-units-required 0)
          0
          -1))

    (define (can-brew? T)
      (let loop ([i 0] [stations-needed 0])
        (cond
          [(= i n)
           (<= stations-needed k)]
          [else
           (let* ([p_i (list-ref potions i)]
                  [t_i (list-ref time i)])
             (if (= p_i 0)
                 (loop (+ i 1) stations-needed)
                 (let ([units-per-station-for-i (floor (/ T t_i))])
                   (if (= units-per-station-for-i 0)
                       #f
                       (let ([current-stations-for-i (ceiling (/ p_i units-per-station-for-i))])
                         (loop (+ i 1) (+ stations-needed current-stations-for-i))))))))]))

    (let loop-bs ([low 0] [high 100000000000000] [ans -1])
      (if (> low high)
          ans
          (let ([mid (+ low (floor (/ (- high low) 2)))])
            (if (can-brew? mid)
                (loop-bs low (- mid 1) mid)
                (loop-bs (+ mid 1) high ans)))))))