(define (num-ways s)
  (let* ((n (string-length s))
         (one-indices
          (for/list ([i (in-range n)]
                     #:when (char=? (string-ref s i) #\1))
            i))
         (total-ones (length one-indices)))

    (cond
      ((not (= (modulo total-ones 3) 0))
       0)
      ((= total-ones 0)
       (let ((val (- n 1)))
         (if (< val 2)
             0
             (/ (* val (- val 1)) 2))))
      (else
       (let* ((target-ones (/ total-ones 3))
              (idx-first-part-end (list-ref one-indices (- target-ones 1)))
              (idx-second-part-start (list-ref one-indices target-ones))
              (idx-second-part-end (list-ref one-indices (- (* 2 target-ones) 1)))
              (idx-third-part-start (list-ref one-indices (* 2 target-ones))))
         (* (- idx-second-part-start idx-first-part-end)
            (- idx-third-part-start idx-second-part-end)))))))