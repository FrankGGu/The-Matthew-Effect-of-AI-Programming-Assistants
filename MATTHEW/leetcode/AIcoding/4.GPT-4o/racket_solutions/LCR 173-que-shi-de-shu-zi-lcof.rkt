(define (check-names names target)
  (if (null? names)
      '()
      (if (equal? (car names) target)
          (cons (car names) (check-names (cdr names) target))
          (check-names (cdr names) target))))

(define (num-names names target)
  (length (check-names names target)))

(define (main)
  (let* ((names '("Alice" "Bob" "Alice" "Eve" "Bob" "Alice"))
         (target "Alice"))
    (num-names names target)))