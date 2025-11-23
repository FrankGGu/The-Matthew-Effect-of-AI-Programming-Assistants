(define (subtract-product-and-sum n)
  (- (* (apply * (map (lambda (c) (- (char->integer c) 48)) (string->list (number->string n)))) 
      (+ (apply + (map (lambda (c) (- (char->integer c) 48)) (string->list (number->string n))))))