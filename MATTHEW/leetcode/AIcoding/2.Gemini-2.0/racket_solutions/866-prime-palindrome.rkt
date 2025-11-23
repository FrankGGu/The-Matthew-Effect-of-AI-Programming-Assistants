(define (prime? n)
  (cond
    [(<= n 1) #f]
    [(= n 2) #t]
    [(even? n) #f]
    [else
     (let loop ([i 3])
       (cond
         [(> (* i i) n) #t]
         [(zero? (remainder n i)) #f]
         [else (loop (+ i 2))]))]))

(define (palindrome? s)
  (equal? s (reverse s)))

(define (generate-palindromes len)
  (cond
    [(= len 1) '(0 1 2 3 4 5 6 7 8 9)]
    [(= len 2) '(11 22 33 44 55 66 77 88 99)]
    [else
     (let ([inner-len (- len 2)])
       (append*
        (for/list ([i (sequence 1 9)])
          (let loop ([j (if (= inner-len 0) '(0) (sequence (expt 10 (- inner-len 1)) (- (expt 10 inner-len) 1)))])
            (list (string->number (string-append (number->string i) (number->string j) (number->string i))))))))]))

(define (prime-palindrome n)
  (let loop ([len 1])
    (let ([pals (generate-palindromes len)])
      (cond
        [(empty? pals) (loop (+ len 1))]
        [else
         (let ([filtered-pals (filter (lambda (x) (and (>= x n) (prime? x))) pals)])
           (cond
             [(empty? filtered-pals) (loop (+ len 1))]
             [else (min filtered-pals)]))])))

(define (prime-palindrome-optimized n)
  (cond
    [(<= n 2) 2]
    [else
     (let loop ([len 1])
       (let ([pals (generate-palindromes len)])
         (cond
           [(empty? pals) (loop (+ len 1))]
           [else
            (let ([filtered-pals (filter (lambda (x) (and (>= x n) (prime? x))) pals)])
              (cond
                [(empty? filtered-pals) (loop (+ len 1))]
                [else (min filtered-pals)]))])))]))

(define (primePalindrome n)
  (prime-palindrome-optimized n))