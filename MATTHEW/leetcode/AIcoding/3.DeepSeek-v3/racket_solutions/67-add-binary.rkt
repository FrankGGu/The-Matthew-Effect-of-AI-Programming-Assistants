(define (add-binary a b)
  (define (bin->num s)
    (let loop ([s s] [acc 0])
      (if (null? s)
          acc
          (loop (cdr s) (+ (* acc 2) (if (char=? (car s) #\1) 1 0))))))
  (define (num->bin n)
    (if (zero? n)
        "0"
        (let loop ([n n] [acc '()])
          (if (zero? n)
              (list->string acc)
              (loop (quotient n 2) (cons (if (odd? n) #\1 #\0) acc))))))
  (num->bin (+ (bin->num (string->list a)) (bin->num (string->list b)))))