(define (num-squareful-perms A)
  (define (is-squareful? a b)
    (let ((sum (+ a b)))
      (if (integer? (sqrt sum)) #t #f)))

  (define (permute nums used current)
    (if (= (length current) (length nums))
        (list current)
        (let loop ((i 0) (result '()))
          (if (= i (length nums))
              result
              (if (or (member i used)
                      (and (> i 0) (= (list-ref nums i) (list-ref nums (- i 1))) (not (member (- i 1) used))))
                  (loop (+ i 1) result)
                  (let ((last-val (if (null? current) #f (last current))))
                    (if (or (null? current) (is-squareful? last-val (list-ref nums i)))
                        (loop (+ i 1) (append result (permute nums (cons i used) (append current (list (list-ref nums i))))))
                        (loop (+ i 1) result)))))))))

  (define (last lst)
    (if (null? lst)
        #f
        (if (null? (cdr lst))
            (car lst)
            (last (cdr lst)))))

  (length (permute (sort A <) '() '())))