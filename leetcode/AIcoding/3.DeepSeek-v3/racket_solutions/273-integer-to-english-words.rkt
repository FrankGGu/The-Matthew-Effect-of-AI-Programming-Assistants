(define (number-to-words num)
  (if (zero? num)
      "Zero"
      (string-trim (helper num))))

(define (helper num)
  (define units '("" "Thousand" "Million" "Billion"))
  (define under-twenty '("" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten" "Eleven" "Twelve" "Thirteen" "Fourteen" "Fifteen" "Sixteen" "Seventeen" "Eighteen" "Nineteen"))
  (define tens '("" "" "Twenty" "Thirty" "Forty" "Fifty" "Sixty" "Seventy" "Eighty" "Ninety"))
  (cond
    [(zero? num) ""]
    [(< num 20) (string-append (list-ref under-twenty num) " ")]
    [(< num 100) (string-append (list-ref tens (quotient num 10)) " " (helper (remainder num 10)))]
    [(< num 1000) (string-append (list-ref under-twenty (quotient num 100)) " Hundred " (helper (remainder num 100)))]
    [else
     (let loop ([n num] [i 0])
       (if (zero? n)
           ""
           (string-append (loop (quotient n 1000) (+ i 1)) (if (zero? (remainder n 1000)) "" (string-append (helper (remainder n 1000)) " " (list-ref units i) " ")))])))