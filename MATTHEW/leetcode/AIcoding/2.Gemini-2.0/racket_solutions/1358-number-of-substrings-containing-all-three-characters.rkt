(define (number-of-substrings s)
  (let* ([n (string-length s)]
         [count (make-vector 3 0)]
         [left 0]
         [ans 0])
    (for ([right (in-range n)])
      (vector-set! count (char->integer (string-ref s right)) (+ 1 (vector-ref count (char->integer (string-ref s right)))))
      (while (and (>= (vector-ref count (char->integer #\a)) 1)
                  (>= (vector-ref count (char->integer #\b)) 1)
                  (>= (vector-ref count (char->integer #\c)) 1))
        (set! ans (+ ans (- n right)))
        (vector-set! count (char->integer (string-ref s left)) (- (vector-ref count (char->integer (string-ref s left))) 1))
        (set! left (+ left 1))))
    ans))