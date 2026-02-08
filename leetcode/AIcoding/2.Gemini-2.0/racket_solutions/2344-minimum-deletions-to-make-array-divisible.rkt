(define (min-deletions nums numsDivide)
  (let* ((g (foldl gcd (car numsDivide) (cdr numsDivide)))
         (sorted-nums (sort nums <))
         (n (length nums)))
    (let loop ((i 0))
      (cond
        ((= i n) -1)
        ((zero? (modulo g (list-ref sorted-nums i))) i)
        (else (loop (+ i 1)))))))