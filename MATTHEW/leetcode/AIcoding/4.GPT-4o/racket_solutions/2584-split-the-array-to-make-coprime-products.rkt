(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (are-coprime a b)
  (= (gcd a b) 1))

(define (splitArrayToCoprimeProducts nums)
  (define (helper nums left right)
    (if (null? left)
        #f
        (let ((left-prod (apply * left))
              (right-prod (apply * right)))
          (if (are-coprime left-prod right-prod)
              #t
              (or (helper (cdr left) (cons (car left) right))
                  (helper (cdr right) left))))))
  (helper nums '() '()))

(define (splitArrayToCoprimeProducts-main nums)
  (splitArrayToCoprimeProducts nums))