(define (find-closest-palindrome n)
  (define s (number->string n))
  (define l (string-length s))
  (define prefix (substring s 0 (quotient (+ l 1) 2)))
  (define (build-palindrome p len)
    (string-append p (if (odd? len) (substring (string-reverse p) 1) (string-reverse p))))
  (define p1 (string->number (build-palindrome prefix l)))
  (define p2 (string->number (build-palindrome (number->string (+ (string->number prefix) 1)) l)))
  (define p3 (if (equal? prefix "0") 0 (string->number (build-palindrome (number->string (- (string->number prefix) 1)) l))))
  (define p4 (if (equal? l 1) 0 9)) ; Special case for single-digit numbers
  (define (abs x) (if (< x 0) (- x) x))
  (define (min-abs a b) (if (< (abs (- n a)) (abs (- n b))) a b))
  (define (min-abs-equal a b)
    (cond
      [(< (abs (- n a)) (abs (- n b))) a]
      [(> (abs (- n a)) (abs (- n b))) b]
      [(< a b) a]
      [else b]))
  (cond
    [(and (= p3 0) (= p4 0)) (number->string p1)]
    [(and (= p3 0) (> p4 0)) (number->string (min-abs-equal p1 p4))]
    [else (number->string (min-abs-equal (min-abs-equal p1 p2) p3))]))