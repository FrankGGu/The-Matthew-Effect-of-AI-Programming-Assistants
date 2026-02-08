(define (sum-digits-of-string-after-convert s k)
  (define (char->int c)
    (- (char->integer c) (char->integer #\a) -1))

  (define (string->sum-of-digits str)
    (string-fold (lambda (c acc) (+ acc (char->int c))) 0 str))

  (define (num->sum-of-digits num)
    (let loop ([n num] [acc 0])
      (if (= n 0)
          acc
          (loop (quotient n 10) (+ acc (remainder n 10))))))

  (define (transform str)
    (number->string (string->sum-of-digits str)))

  (define (iterate-sum str k)
    (if (= k 0)
        str
        (iterate-sum (number->string (num->sum-of-digits (string->number str))) (- k 1))))

  (define converted-string
    (string-append* (map (compose number->string char->int) (string->list s))))

  (num->sum-of-digits (string->number (iterate-sum converted-string k))))