(define (numberToWords num)
  (define less-than-20
    '("Zero" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten"
      "Eleven" "Twelve" "Thirteen" "Fourteen" "Fifteen" "Sixteen" "Seventeen" 
      "Eighteen" "Nineteen"))

  (define tens
    '("Zero" "Ten" "Twenty" "Thirty" "Forty" "Fifty" "Sixty" "Seventy" "Eighty" "Ninety"))

  (define thousands
    '("" "Thousand" "Million" "Billion"))

  (define (convert n)
    (if (< n 20)
        (list-ref less-than-20 n)
        (if (< n 100)
            (string-append (list-ref tens (quotient n 10)) 
                           (if (zero? (modulo n 10)) "" 
                               (string-append " " (convert (modulo n 10)))))
            (string-append (convert (quotient n 100)) " Hundred" 
                           (if (zero? (modulo n 100)) "" 
                               (string-append " " (convert (modulo n 100))))))))

  (define (helper n)
    (if (zero? n) "Zero"
        (let loop ((n n) (i 0) (words '()))
          (if (zero? n)
              (string-join (reverse words) " ")
              (let ((chunk (modulo n 1000)))
                (set! n (quotient n 1000))
                (when (not (zero? chunk))
                  (set! words (cons (string-append (convert chunk) 
                                                     (if (zero? i) "" 
                                                         (string-append " " (list-ref thousands i)))) 
                                     words)))
                (loop n (add1 i) words))))))

  (helper num))