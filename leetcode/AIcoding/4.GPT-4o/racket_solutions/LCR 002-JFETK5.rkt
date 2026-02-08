(define (add-binary a b)
  (define (binary-to-decimal bin)
    (foldl (lambda (x acc) (+ (* acc 2) (if (equal? x #\1) 1 0))) 0 bin))

  (define (decimal-to-binary n)
    (if (= n 0)
        '()
        (append (decimal-to-binary (quotient n 2)) (list (if (even? n) #\0 #\1)))))

  (define dec-a (binary-to-decimal a))
  (define dec-b (binary-to-decimal b))
  (define sum (+ dec-a dec-b))
  (if (= sum 0)
      "0"
      (list->string (decimal-to-binary sum))))

(add-binary "11" "1")