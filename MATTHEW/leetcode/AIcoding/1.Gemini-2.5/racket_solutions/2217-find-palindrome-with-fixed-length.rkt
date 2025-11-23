(define (find-palindrome-with-fixed-length queries intLength)
  (let* ([half-length (ceiling (/ intLength 2))]
         [start-num (expt 10 (- half-length 1))]
         [max-first-half-num (- (expt 10 half-length) 1)])
    (map (lambda (q)
           (let ([first-half-candidate (+ start-num (- q 1))])
             (if (> first-half-candidate max-first-half-num)
                 -1
                 (let* ([s-half (number->string first-half-candidate)]
                        [s-second-half (if (even? intLength)
                                           (string-reverse s-half)
                                           (string-reverse (substring s-half 0 (- half-length 1))))]
                        [palindrome-str (string-append s-half s-second-half)])
                   (string->number palindrome-str)))))
         queries)))