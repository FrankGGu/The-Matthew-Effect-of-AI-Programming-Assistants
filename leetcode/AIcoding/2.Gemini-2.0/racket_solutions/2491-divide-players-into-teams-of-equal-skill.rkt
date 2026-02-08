(define (divide-players skill)
  (let* ((n (length skill))
         (sum (apply + skill))
         (team-size (/ sum (/ n 2)))
         (skill-sorted (sort skill <))
         (product 0))
    (let loop ((i 0))
      (cond
        ((= i (/ n 2)) product)
        ((not (= (+ (list-ref skill-sorted i) (list-ref skill-sorted (- n i 1))) team-size)) -1)
        (else (loop (+ i 1))))
    (if (= -1 (loop 0))
        -1
        (let loop2 ((i 0) (prod 0))
          (cond
            ((= i (/ n 2)) prod)
            (else (loop2 (+ i 1) (+ prod (* (list-ref skill-sorted i) (list-ref skill-sorted (- n i 1)))))))))))