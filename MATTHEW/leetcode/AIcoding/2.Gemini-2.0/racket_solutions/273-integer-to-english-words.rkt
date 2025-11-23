(define (number-to-words num)
  (define ones '("" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine"))
  (define teens '("Ten" "Eleven" "Twelve" "Thirteen" "Fourteen" "Fifteen" "Sixteen" "Seventeen" "Eighteen" "Nineteen"))
  (define tens '("" "" "Twenty" "Thirty" "Forty" "Fifty" "Sixty" "Seventy" "Eighty" "Ninety"))

  (define (helper n)
    (cond
      ((= n 0) "")
      ((< n 10) (list-ref ones n))
      ((< n 20) (list-ref teens (- n 10)))
      ((< n 100) (string-append (list-ref tens (quotient n 10)) " " (helper (remainder n 10))))
      ((< n 1000) (string-append (list-ref ones (quotient n 100)) " Hundred " (helper (remainder n 100))))
      ((< n 1000000) (string-append (helper (quotient n 1000)) " Thousand " (helper (remainder n 1000))))
      ((< n 1000000000) (string-append (helper (quotient n 1000000)) " Million " (helper (remainder n 1000000))))
      (else (string-append (helper (quotient n 1000000000)) " Billion " (helper (remainder n 1000000000))))))

  (let ((result (helper num)))
    (if (string=? result "")
        "Zero"
        (string-trim (string-replace-all result "  " " ")))))