(define (maximize-xor nums queries)
  (define (get-max-xor num nums)
    (let loop ([max-xor 0] [rest nums])
      (if (null? rest)
          max-xor
          (let ([current-xor (bitwise-xor num (car rest))])
            (loop (max max-xor current-xor) (cdr rest))))))

  (map (lambda (query)
         (let ([xi (car query)] [mi (cadr query)])
           (let ([filtered (filter (lambda (x) (<= x mi)) nums)])
             (if (null? filtered)
                 -1
                 (get-max-xor xi filtered)))))
       queries))