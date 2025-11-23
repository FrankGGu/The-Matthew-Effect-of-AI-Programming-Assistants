(define (insert-sorted val lst cmp)
  (cond
    ((empty? lst) (list val))
    ((cmp val (car lst)) (cons val lst))
    (else (cons (car lst) (insert-sorted val (cdr lst) cmp)))))

(define (last-stone-weight stones)
  (let loop ((s (sort stones >)))
    (cond
      ((<= (length s) 1)
       (if (empty? s) 0 (car s)))
      (else
       (let* ((y (car s))
              (x (cadr s))
              (rest-stones (cddr s))
              (diff (- y x)))
         (if (= diff 0)
             (loop rest-stones)
             (loop (insert-sorted diff rest-stones >))))))))