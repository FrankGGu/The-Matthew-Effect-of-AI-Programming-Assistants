(define (nearest-palindrome n)
  (define (mirror-half s)
    (let* ([half-len (quotient (string-length s) 2)]
           [half (substring s 0 half-len)])
      (string-append half (string-reverse half))))

  (define (next-palindrome s)
    (let* ([half-len (quotient (string-length s) 2)]
           [half (substring s 0 half-len)]
           [half-num (string->number half)]
           [next-half (number->string (+ half-num 1))]
           [prev-half (number->string (- half-num 1))])
      (list (string-append next-half (string-reverse (substring next-half 0 (- (string-length next-half) (if (odd? (string-length s)) 1 0))))
            (string-append prev-half (string-reverse (substring prev-half 0 (- (string-length prev-half) (if (odd? (string-length s)) 1 0)))))))

  (define (string->num s) (string->number s))
  (define (num->string n) (number->string n))

  (define s (num->string n))
  (define len (string-length s))

  (cond
    [(= len 1) (num->string (- n 1))]
    [(equal? s (string-reverse s)) (nearest-palindrome (- n 1))]
    [else
     (let* ([mirror (mirror-half s)]
            [next-prev (next-palindrome s)]
            [next (car next-prev)]
            [prev (cadr next-prev)]
            [candidates (list mirror next prev)]
            [nums (map string->num candidates)]
            [diffs (map (lambda (x) (abs (- x n))) nums)]
            [min-diff (apply min diffs)]
            [filtered (filter (lambda (x) (= (abs (- x n)) min-diff)) nums)])
       (num->string (apply min filtered)))]))