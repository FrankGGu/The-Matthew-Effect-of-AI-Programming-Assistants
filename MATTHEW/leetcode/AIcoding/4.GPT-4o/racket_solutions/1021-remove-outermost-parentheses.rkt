(define (removeOuterParentheses s)
  (define (helper s index count)
    (cond
      [(= index (string-length s)) ""]
      [(char=? (string-ref s index) #\() 
       (if (= count 0) 
           (helper s (+ index 1) (+ count 1))
           (string-append (helper s (+ index 1) (+ count 1)) (string (string-ref s index))))]
      [(char=? (string-ref s index) #\)) 
       (if (= count 1) 
           (helper s (+ index 1) (- count 1))
           (string-append (helper s (+ index 1) (- count 1)) (string (string-ref s index))))]
      [else (error "Invalid character in string")]))
  (helper s 0 0))

(removeOuterParentheses "(())()")