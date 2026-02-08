(define (circular-permutation n start)
  (define (binary-rep n)
    (if (= n 0) '() (append (binary-rep (quotient n 2)) (list (modulo n 2)))))
  (define (rotate lst k)
    (append (drop lst k) (take lst k)))
  (define binary-list (binary-rep (expt 2 n)))
  (define start-index (find-index (lambda (x) (= x start)) binary-list))
  (rotate binary-list start-index))

(define (find-index pred lst)
  (define (loop idx lst)
    (cond
      [(null? lst) -1]
      [(pred (car lst)) idx]
      [else (loop (+ idx 1) (cdr lst))]))
  (loop 0 lst))

(define (take lst n)
  (if (or (null? lst) (= n 0)) '() (cons (car lst) (take (cdr lst) (- n 1)))))

(define (drop lst n)
  (if (or (null? lst) (= n 0)) lst (drop (cdr lst) (- n 1))))