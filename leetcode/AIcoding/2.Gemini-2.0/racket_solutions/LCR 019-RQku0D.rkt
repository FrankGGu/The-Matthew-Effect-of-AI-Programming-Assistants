(define (validPalindrome s)
  (define (is-palindrome sub-s)
    (equal? sub-s (string-reverse sub-s)))

  (define (check-with-removal left right removed?)
    (cond
      [(> left right) #t]
      [(= (string-ref s left) (string-ref s right))
       (check-with-removal (+ left 1) (- right 1) removed?)]
      [removed? #f]
      [else
       (or (check-with-removal (+ left 1) right #t)
           (check-with-removal left (- right 1) #t))]))

  (check-with-removal 0 (- (string-length s) 1) #f))