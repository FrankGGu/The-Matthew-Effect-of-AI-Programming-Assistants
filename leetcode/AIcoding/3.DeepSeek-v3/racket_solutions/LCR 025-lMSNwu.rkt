(define/contract (add-two-numbers l1 l2)
  (-> list? list? list?)
  (define (reverse-list l)
    (let loop ([l l] [acc '()])
      (if (null? l) acc
          (loop (cdr l) (cons (car l) acc)))))
  (define (list->num l)
    (let loop ([l l] [acc 0])
      (if (null? l) acc
          (loop (cdr l) (+ (* acc 10) (car l))))))
  (define (num->list n)
    (if (zero? n) '(0)
        (let loop ([n n] [acc '()])
          (if (zero? n) acc
              (loop (quotient n 10) (cons (remainder n 10) acc))))))
  (num->list (+ (list->num (reverse-list l1)) (list->num (reverse-list l2)))))