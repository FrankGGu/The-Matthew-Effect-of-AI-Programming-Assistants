(define (digitGame n)
  (define (countDigits x)
    (if (= x 0) 0
        (+ 1 (countDigits (quotient x 10)))))
  (define (canWin n)
    (if (zero? n) #f
        (let ((digits (countDigits n)))
          (if (even? digits) #t (canWin (sub1 n))))))
  (canWin n))

(digitGame 5)  ; Example call to the function