(define (remove-duplicates nums)
  (if (null? nums)
      0
      (let loop ((prev (car nums)) (rest (cdr nums)) (count 1))
        (if (null? rest)
            count
            (if (= (car rest) prev)
                (loop prev (cdr rest) count)
                (loop (car rest) (cdr rest) (+ count 1)))))))