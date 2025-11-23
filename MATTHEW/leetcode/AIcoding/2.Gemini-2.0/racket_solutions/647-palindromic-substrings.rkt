(define (count-substrings s)
  (define n (string-length s))
  (define count (box 0))

  (define (extend-palindrome left right)
    (while (and (>= left 0) (< right n) (char=? (string-ref s left) (string-ref s right)))
      (set-box! count (+ (unbox count) 1))
      (set! left (- left 1))
      (set! right (+ right 1))))

  (for ([i (in-range n)])
    (extend-palindrome i i)
    (extend-palindrome i (+ i 1)))

  (unbox count))