(define (minimumAmountOfDamage dealt)
  (define (helper dealt num)
    (if (zero? num)
        0
        (let ((damage (car dealt)))
          (min 
            (+ damage (helper (cdr dealt) (sub1 num)))
            (helper (cdr dealt) (sub1 num))))))
  (helper dealt (length dealt)))

(minimumAmountOfDamage '(3 1 4 1 5 9 2 6 5 3 5))