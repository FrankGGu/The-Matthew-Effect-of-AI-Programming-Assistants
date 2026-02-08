(define class-MethodChaining
  (let ((x 0))
    (define (add (num))
      (set! x (+ x num))
      (self))
    (define (subtract (num))
      (set! x (- x num))
      (self))
    (define (multiply (num))
      (set! x (* x num))
      (self))
    (define (divide (num))
      (set! x (/ x num))
      (self))
    (define (getResult)
      x)
    (define (self) (lambda () class-MethodChaining))
    (define (new) (lambda () class-MethodChaining))
    (new)))

(define (create)
  (class-MethodChaining))

(define (add num)
  ((add num)))

(define (subtract num)
  ((subtract num)))

(define (multiply num)
  ((multiply num)))

(define (divide num)
  ((divide num)))

(define (getResult)
  ((getResult)))