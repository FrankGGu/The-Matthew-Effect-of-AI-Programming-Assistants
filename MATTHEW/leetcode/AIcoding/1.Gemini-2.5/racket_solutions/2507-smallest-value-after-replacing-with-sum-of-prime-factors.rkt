(define (prime-factors num)
  (let loop ((n num) (d 2) (factors '()))
    (cond
      ((> (* d d) n)
       (if (> n 1) (reverse (cons n factors)) (reverse factors)))
      ((zero? (remainder n d))
       (loop (/ n d) d (cons d factors)))
      (else
       (loop n (+ d 1) factors)))))

(define (smallest-value n)
  (let loop ((current-n n))
    (let* ((factors (prime-factors current-n))
           (sum-factors (apply + factors)))
      (if (= sum-factors current-n)
          current-n
          (loop sum-factors)))))