(define (minCost arr)
  (define (is-palindrome? n)
    (define s (number->string n))
    (equal? s (list->string (reverse (string->list s)))))

  (define (calculate-cost target)
    (apply + (map (lambda (x) (abs (- x target))) arr)))

  (define (find-median sorted-arr)
    (let ((len (length sorted-arr)))
      (if (odd? len)
          (list-ref sorted-arr (quotient len 2))
          (let ((mid (quotient len 2)))
            (list-ref sorted-arr mid)))))

  (define sorted-arr (sort arr <))
  (define median (find-median sorted-arr))

  (define (find-nearest-palindrome num)
    (define s (number->string num))
    (define len (string-length s))

    (define (generate-palindrome half-str)
      (string-append half-str (list->string (reverse (string->list half-str)))))

    (define (generate-odd-palindrome half-str mid-char)
      (string-append half-str (string mid-char) (list->string (reverse (string->list half-str)))))

    (define (string->number str)
      (string->number str))

    (let* ((half-len (quotient len 2))
           (half-str (substring s 0 half-len)))
      (cond
        ((odd? len)
         (let* ((mid-char (string-ref s half-len))
                (palindrome1 (string->number (generate-odd-palindrome half-str mid-char)))
                (mid-num (string->number (string mid-char)))
                (palindrome2 (string->number (generate-odd-palindrome half-str (integer->char (+ 1 (char->integer mid-char))))))
                (palindrome3 (string->number (generate-odd-palindrome (cond [(equal? half-str "") ""][else (substring half-str 0 (- (string-length half-str) 1))]) #\9))))

           (cond
             [(and (equal? (string->number s) 0) (equal? palindrome1 0)) 0]
             [(< palindrome1 num)
              (cond
                [(< num palindrome2) (min (calculate-cost palindrome1) (calculate-cost palindrome2))]
                [else (if (>= (string-length (number->string palindrome2)) len) (calculate-cost palindrome1) (min (calculate-cost palindrome1) (calculate-cost palindrome3)))])]
             [else (calculate-cost palindrome1)]
             )))
        (else
         (let* ((palindrome1 (string->number (generate-palindrome half-str)))
                (palindrome2 (string->number (generate-palindrome (substring (number->string (+ 1 (string->number half-str))) 0 half-len))))
                (palindrome3 (string->number (generate-palindrome (cond [(equal? half-str "") ""][else (substring half-str 0 (- (string-length half-str) 1))]))))
           (cond
             [(and (equal? (string->number s) 0) (equal? palindrome1 0)) 0]
             [(< palindrome1 num)
              (cond
                [(< num palindrome2) (min (calculate-cost palindrome1) (calculate-cost palindrome2))]
                [else (if (>= (string-length (number->string palindrome2)) len) (calculate-cost palindrome1) (min (calculate-cost palindrome1) (calculate-cost palindrome3)))])]
             [else (calculate-cost palindrome1)]
             )))))))

  (define palindrome1 (find-nearest-palindrome median))
  (define palindrome2 (find-nearest-palindrome (+ 1 median)))
  (define palindrome3 (find-nearest-palindrome (- median 1)))

  (min (calculate-cost palindrome1) (calculate-cost palindrome2) (calculate-cost palindrome3)))