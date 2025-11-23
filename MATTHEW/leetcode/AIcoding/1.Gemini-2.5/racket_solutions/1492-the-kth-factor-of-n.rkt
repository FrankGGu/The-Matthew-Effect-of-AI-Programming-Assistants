(define (kth-factor n k)
  (let loop ((i 1) (count 0))
    (cond
      ((> i n) -1)
      ((zero? (modulo n i))
       (let ((new-count (+ count 1)))
         (if (= new-count k)
             i
             (loop (+ i 1) new-count))))
      (else
       (loop (+ i 1) count)))))