(define (min-moves nums k)
  (let loop ((i 0) (j 0) (ones '()) (res +inf.0))
    (cond
      [(>= i (length nums))
       (if (null? ones) 0 (inexact->exact res))]
      [(= (list-ref nums i) 1)
       (let* ((new-ones (cons i ones))
              (len (length new-ones)))
         (if (>= len k)
             (let* ((median (list-ref new-ones (quotient k 2)))
                    (total (for/sum ([pos (in-list new-ones)]
                                     [m (in-range k)])
                             (abs (- pos median)))))
               (loop (add1 i) j new-ones (min res total)))
             (loop (add1 i) j new-ones res)))]
      [else
       (loop (add1 i) j ones res)])))