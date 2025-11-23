(define (countSubstrings s)
  (define (expandAroundCenter left right)
    (let loop ((l left) (r right) (count 0))
      (if (and (>= l 0) (< r (string-length s)) (char=? (string-ref s l) (string-ref s r)))
          (loop (- l 1) (+ r 1) (+ count 1))
          count)))

  (define total-count
    (for/fold ((count 0)) ((i 0) (n (string-length s)))
      (if (< i n)
          (+ count (expandAroundCenter i i) (expandAroundCenter i (+ i 1)))
          count)))

  total-count)

(countSubstrings "abc") ; should return 3
(countSubstrings "aaa") ; should return 6