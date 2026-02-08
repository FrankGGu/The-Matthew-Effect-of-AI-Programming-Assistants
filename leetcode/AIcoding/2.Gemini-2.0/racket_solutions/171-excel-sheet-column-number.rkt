(define (titleToNumber s)
  (let loop ([str (string->list s)] [res 0])
    (if (null? str)
        res
        (loop (cdr str) (+ (* res 26) (- (char->integer (car str)) (char->integer #\A) -1))))))