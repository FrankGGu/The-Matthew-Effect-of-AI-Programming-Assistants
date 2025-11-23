(define (minimum-right-shifts-to-sort-the-array nums)
  (let* ((n (length nums))
         (sorted-nums (sort nums <)))
    (let loop ((k 0))
      (cond
        ((= k n) -1)
        (else
         (let* ((num-elements-from-end k)
                (shifted-part-from-end (list-tail nums (- n num-elements-from-end)))
                (remaining-front-part (list-head nums (- n num-elements-from-end)))
                (current-shifted-nums (append shifted-part-from-end remaining-front-part)))
           (if (equal? current-shifted-nums sorted-nums)
               k
               (loop (+ k 1)))))))))