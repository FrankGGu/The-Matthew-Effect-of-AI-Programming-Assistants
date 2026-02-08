(define (create-target-array nums index)
  (let loop ([nums nums] [index index] [target '()])
    (cond
      [(null? nums) (reverse target)]
      [else
       (let ([n (car nums)] [i (car index)])
         (loop (cdr nums) (cdr index) (insert-at n i target)))])))

(define (insert-at n i lst)
  (cond
    [(= i 0) (cons n lst)]
    [else (cons (car lst) (insert-at n (sub1 i) (cdr lst)))]))