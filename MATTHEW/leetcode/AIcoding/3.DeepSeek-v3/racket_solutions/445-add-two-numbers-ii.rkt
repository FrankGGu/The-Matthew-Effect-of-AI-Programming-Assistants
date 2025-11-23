(define/contract (add-two-numbers l1 l2)
  (-> list? list? list?)
  (define (reverse-list lst)
    (let loop ([lst lst] [acc '()])
      (if (null? lst)
          acc
          (loop (cdr lst) (cons (car lst) acc)))))

  (define (list->num lst)
    (let loop ([lst lst] [num 0])
      (if (null? lst)
          num
          (loop (cdr lst) (+ (* num 10) (car lst)))))

  (define (num->list num)
    (if (zero? num)
        '(0)
        (let loop ([num num] [acc '()])
          (if (zero? num)
              acc
              (loop (quotient num 10) (cons (remainder num 10) acc))))))

  (let* ([rev-l1 (reverse-list l1)]
         [rev-l2 (reverse-list l2)]
         [num1 (list->num rev-l1)]
         [num2 (list->num rev-l2)]
         [sum (+ num1 num2)])
    (num->list sum)))