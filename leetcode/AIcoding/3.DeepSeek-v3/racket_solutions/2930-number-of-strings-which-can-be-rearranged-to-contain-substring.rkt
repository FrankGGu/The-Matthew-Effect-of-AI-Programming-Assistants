(define MOD 1000000007)

(define (power x n)
  (cond
    [(zero? n) 1]
    [(even? n) (modulo (sqr (power x (quotient n 2))) MOD)]
    [else (modulo (* x (power x (sub1 n))) MOD)]))

(define (count-strings n)
  (let* ([total (power 26 n)]
         [no-l (power 25 n)]
         [no-t (power 25 n)]
         [no-e (power 24 n)]
         [no-l-and-no-t (power 24 n)]
         [no-l-and-no-e (power 23 n)]
         [no-t-and-no-e (power 23 n)]
         [no-l-and-no-t-and-no-e (power 22 n)]
         [invalid (+ no-l no-t no-e (- no-l-and-no-t) (- no-l-and-no-e) (- no-t-and-no-e) no-l-and-no-t-and-no-e)])
    (modulo (- total invalid) MOD)))