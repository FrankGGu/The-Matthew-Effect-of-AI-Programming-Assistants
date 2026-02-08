(define (smallestIndexWithDigitSumEqualToIndex n)
  (for/fold ([result -1]) ([i 0 (in-range n)])
    (let ([digit-sum (fold + 0 (map (lambda (c) (string->number (string c))) (string->list (number->string i))))])
      (if (= digit-sum i)
          (if (= result -1) i result)
          result))))

(smallestIndexWithDigitSumEqualToIndex n)