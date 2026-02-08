(define (count-substrings s)
  (let ((n (string-length s)))
    (let loop ((i 0) (count 0))
      (if (= i n)
          count
          (loop (+ i 1) (+ count (count-palindromes s i)))))))

(define (count-palindromes s i)
  (let ((n (string-length s)))
    (letrec ((expand (lambda (left right count)
                      (if (and (>= left 0) (< right n) (char=? (string-ref s left) (string-ref s right)))
                          (expand (- left 1) (+ right 1) (+ count 1))
                          count))))
      (+ (expand i i 0) (expand i (+ i 1) 0)))))