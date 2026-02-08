(define (minMovesToMakePalindrome s)
  (define n (string-length s))
  (define (count-cycles left right)
    (if (>= left right)
        0
        (let loop ((l left) (r right) (moves 0))
          (cond
            ((char=? (string-ref s l) (string-ref s r))
             (loop (add1 l) (sub1 r) moves))
            (else
             (let ((k (or (string-index s (string-ref s r) l)
                          (string-index s (string-ref s l) l))))
               (if k
                   (loop (add1 l) (sub1 r) (+ moves (- k l)))
                   (loop (add1 l) (sub1 r) moves))))))))
  (count-cycles 0 (sub1 n)))