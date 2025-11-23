(define (majority-element nums)
  (car
   (foldl
    (lambda (num acc)
      (let ((candidate (car acc))
            (count (cdr acc)))
        (if (= count 0)
            (cons num 1)
            (if (= num candidate)
                (cons candidate (+ count 1))
                (cons candidate (- count 1))))))
    (cons 0 0)
    nums)))