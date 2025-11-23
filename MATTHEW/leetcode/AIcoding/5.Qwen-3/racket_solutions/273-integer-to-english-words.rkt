#lang racket

(define (number-to-words num)
  (cond [(= num 0) "Zero"]
        [else (string-append (helper num) "")]))

(define (helper num)
  (cond [(< num 20) (less-than-twenty num)]
        [(< num 100) (tens (quotient num 10) (remainder num 10))]
        [(< num 1000) (hundreds num)]
        [(< num 1000000) (thousands num)]
        [(< num 1000000000) (millions num)]
        [else (billions num)]))

(define (less-than-twenty n)
  (match n
    [0 "Zero"]
    [1 "One"]
    [2 "Two"]
    [3 "Three"]
    [4 "Four"]
    [5 "Five"]
    [6 "Six"]
    [7 "Seven"]
    [8 "Eight"]
    [9 "Nine"]
    [10 "Ten"]
    [11 "Eleven"]
    [12 "Twelve"]
    [13 "Thirteen"]
    [14 "Fourteen"]
    [15 "Fifteen"]
    [16 "Sixteen"]
    [17 "Seventeen"]
    [18 "Eighteen"]
    [19 "Nineteen"]))

(define (tens d e)
  (cond [(= d 2) (string-append "Twenty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 3) (string-append "Thirty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 4) (string-append "Forty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 5) (string-append "Fifty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 6) (string-append "Sixty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 7) (string-append "Seventy" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 8) (string-append "Eighty" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [(= d 9) (string-append "Ninety" (if (= e 0) "" (string-append " " (less-than-twenty e))))]
        [else (less-than-twenty (+ (* d 10) e))]))

(define (hundreds n)
  (let ([h (quotient n 100)]
        [r (remainder n 100)])
    (string-append (less-than-twenty h) " Hundred"
                   (if (= r 0) "" (string-append " " (helper r))))))

(define (thousands n)
  (let ([t (quotient n 1000)]
        [r (remainder n 1000)])
    (string-append (helper t) " Thousand"
                   (if (= r 0) "" (string-append " " (helper r))))))

(define (millions n)
  (let ([m (quotient n 1000000)]
        [r (remainder n 1000000)])
    (string-append (helper m) " Million"
                   (if (= r 0) "" (string-append " " (helper r))))))

(define (billions n)
  (let ([b (quotient n 1000000000)]
        [r (remainder n 1000000000)])
    (string-append (helper b) " Billion"
                   (if (= r 0) "" (string-append " " (helper r))))))