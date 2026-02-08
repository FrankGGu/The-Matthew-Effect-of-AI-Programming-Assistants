(define (separateSquares nums)
  (let loop ((nums nums) (pos '()) (neg '()))
    (cond
      ((null? nums) (list pos neg))
      ((>= (car nums) 0) (loop (cdr nums) (cons (car nums) pos) neg))
      (else (loop (cdr nums) pos (cons (car nums) neg))))))

(define (separateSquaresI nums)
  (let-values ([(pos neg) (separateSquares nums)])
    (list (reverse pos) (reverse neg))))