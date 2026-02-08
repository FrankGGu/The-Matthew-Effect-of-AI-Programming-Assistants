(define/contract (last-stone-weight stones)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([stones (sort stones >)])
    (cond
      [(null? stones) 0]
      [(null? (cdr stones)) (car stones)]
      [else
       (let* ([x (car stones)]
              [y (cadr stones)]
              [new-stones (cddr stones)])
         (if (= x y)
             (loop new-stones)
             (loop (sort (cons (- x y) new-stones) >)))])))