(define (number-to-words num)
  (define ones
    (vector "" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten"
            "Eleven" "Twelve" "Thirteen" "Fourteen" "Fifteen" "Sixteen" "Seventeen" "Eighteen" "Nineteen"))

  (define tens
    (vector "" "" "Twenty" "Thirty" "Forty" "Fifty" "Sixty" "Seventy" "Eighty" "Ninety"))

  (define suffixes
    (vector "" "Thousand" "Million" "Billion"))

  (define (convert-less-than-thousand n)
    (cond
      [(zero? n) '()]
      [(< n 20) (list (vector-ref ones n))]
      [(< n 100)
       (let* ([t (quotient n 10)]
              [o (remainder n 10)])
         (if (zero? o)
             (list (vector-ref tens t))
             (list (vector-ref tens t) (vector-ref ones o))))]
      [else
       (let* ([h (quotient n 100)]
              [rem (remainder n 100)])
         (append (list (vector-ref ones h) "Hundred")
                 (convert-less-than-thousand rem)))]))

  (cond
    [(zero? num) "Zero"]
    [else
     (let loop ([n num] [suffix-idx 0] [result-word-lists '()])
       (if (zero? n)
           (string-join (apply append result-word-lists) " ")
           (let* ([segment (remainder n 1000)]
                  [next-n (quotient n 1000)])
             (if (zero? segment)
                 (loop next-n (+ suffix-idx 1) result-word-lists)
                 (let* ([segment-words-list (convert-less-than-thousand segment)]
                        [current-word-list (if (zero? suffix-idx)
                                               segment-words-list
                                               (append segment-words-list (list (vector-ref suffixes suffix-idx))))])
                   (loop next-n (+ suffix-idx 1) (cons current-word-list result-word-lists)))))))]))