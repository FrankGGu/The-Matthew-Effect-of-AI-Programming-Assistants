(define (largest-palindromic num)
  (let* ([counts (make-hash)]
         [digits (string->list (number->string num))]
         [max-odd -1]
         [half ""])
    (for ([d digits])
      (hash-update! counts d add1 0))
    (for ([d (sort (hash-keys counts) char>?)])
      (let ([cnt (hash-ref counts d)])
        (when (and (odd? cnt) (> (char->integer d) max-odd))
          (set! max-odd (char->integer d)))
        (set! half (string-append half (make-string (quotient cnt 2) d)))))
    (let* ([leading-zero? (and (not (string-empty? half)) (char=? (string-ref half 0) #\0))]
           [palindrome (if (string-empty? half)
                           (if (>= max-odd 0) (string (integer->char max-odd)) "")
                         (string-append half
                                       (if (>= max-odd 0) (string (integer->char max-odd)) "")
                                       (list->string (reverse (string->list half))))])
      (if (string-empty? palindrome) "0"
          (if leading-zero? "0" palindrome)))))