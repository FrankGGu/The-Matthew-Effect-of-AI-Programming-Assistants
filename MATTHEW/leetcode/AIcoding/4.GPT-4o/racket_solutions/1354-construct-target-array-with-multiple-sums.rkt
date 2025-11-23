(define (isPossible target)
  (define total (apply + target))
  (define max (apply max target))
  (define target (sort target >))

  (define (helper target total)
    (if (or (null? target) (<= (car target) 0))
        #f
        (let ((max (car target)))
          (if (= max 1)
              #t
              (let ((prev-total (- total max))
                    (new-max (- total max)))
                (if (or (= prev-total 0) (= new-max 0))
                    #f
                    (if (> new-max 0)
                        (helper (cons new-max (cdr target)) (- total max))
                        #f)))))))

  (if (= (length target) 1)
      (= (car target) 1)
      (helper target total)))