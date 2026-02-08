(define (maximum-length-substrings s)
  (define (count-substrings s)
    (define n (string-length s))
    (define (max-length l r)
      (if (and (>= r n) (<= l 0))
          0
          (if (and (< l 0) (>= r n))
              0
              (if (and (>= r n) (< l 0))
                  0
                  (if (and (>= l 0) (< r n))
                      (if (equal? (string-ref s l) (string-ref s r))
                          (+ 1 (max-length (1+ l) (1- r)))
                          (max (max-length (1+ l) r) (max-length l (1- r))))))))))

    (define (helper i)
      (if (>= i n)
          '()
          (let ((current (max-length i (sub1 n))))
            (cons current (helper (1+ i))))))

  (define lengths (helper 0))
  (define (filter-zero lst)
    (filter (lambda (x) (> x 0)) lst))

  (define max-lengths (filter-zero lengths))
  (if (null? max-lengths)
      0
      (apply max max-lengths)))

(maximum-length-substrings "abacaba")