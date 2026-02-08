(define (sum-of-encrypted-numbers nums)
  (define (encrypt num)
    (if (= num 0)
        0
        (let* ([digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) 
                            (string->list (number->string num)))]
               [max-digit (apply max digits)])
          (foldl (lambda (d res) (+ (* res 10) max-digit)) 0 digits))))
  (apply + (map encrypt nums)))