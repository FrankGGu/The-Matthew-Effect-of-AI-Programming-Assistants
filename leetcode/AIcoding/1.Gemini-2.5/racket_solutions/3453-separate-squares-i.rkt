(define (perfect-square? n)
  (if (< n 0)
      #f
      (let ([root (round (sqrt n))])
        (= (* root root) n))))

(define (separate-squares nums)
  (let loop ([remaining nums]
             [squares '()]
             [non-squares '()])
    (if (empty? remaining)
        (list (reverse squares) (reverse non-squares))
        (let ([n (car remaining)])
          (if (perfect-square? n)
              (loop (cdr remaining) (cons n squares) non-squares)
              (loop (cdr remaining) squares (cons n non-squares)))))))