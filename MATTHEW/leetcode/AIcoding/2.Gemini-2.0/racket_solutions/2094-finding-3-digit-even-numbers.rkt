(define (find-even-numbers digits)
  (define (helper current-digits used current-num)
    (cond
      [(and (= (length current-digits) 3) (even? current-num))
       (list current-num)]
      [(>= (length current-digits) 3)
       '()]
      [else
       (let loop ([i 0] [acc '()])
         (cond
           [(= i (length digits))
            acc]
           [else
            (let ([digit (list-ref digits i)])
              (if (not (member i used))
                  (append acc (helper (append current-digits (list digit)) (append used (list i)) (+ (* current-num 10) digit)))
                  acc))
            (loop (+ i 1) acc))]))]))

  (let ([result (sort (remove-duplicates (helper '() '() 0)) <)])
    result))