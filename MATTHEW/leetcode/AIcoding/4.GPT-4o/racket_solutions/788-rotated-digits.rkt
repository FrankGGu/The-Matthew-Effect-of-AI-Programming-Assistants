(define (rotatedDigits n)
  (define (is-good x)
    (define str-x (number->string x))
    (and (not (string-contains? str-x "3"))
         (not (string-contains? str-x "4"))
         (not (string-contains? str-x "7"))
         (or (string-contains? str-x "2")
             (string-contains? str-x "5")
             (string-contains? str-x "6")
             (string-contains? str-x "9"))))

  (define (count-good-digits count)
    (if (= count 0)
        0
        (+ (if (is-good count) 1 0) (count-good-digits (- count 1)))))

  (count-good-digits n))