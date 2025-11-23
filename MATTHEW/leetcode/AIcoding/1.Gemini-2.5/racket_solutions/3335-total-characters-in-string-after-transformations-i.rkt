(define (get-lucky s k)
  ;; Step 1: Convert string s to its initial concatenated digit string.
  ;; Example: "abc" -> "123"
  (define initial-digit-string
    (string-join
      (map (lambda (c)
             (number->string (+ 1 (- (char->integer c) (char->integer #\a)))))
           (string->list s))
      ""))

  ;; Helper function to sum the digits of a string representing a number.
  ;; Example: "123" -> 1 + 2 + 3 = 6
  (define (sum-digits-from-string digit-str)
    (for/sum ([char (in-string digit-str)])
      (- (char->integer char) (char->integer #\0))))

  ;; Helper function to sum the digits of an integer.
  ;; Example: 57 -> 5 + 7 = 12
  (define (sum-digits-from-integer n)
    (if (= n 0)
        0
        (let loop ([num n] [sum 0])
          (if (= num 0)
              sum
              (loop (quotient num 10) (+ sum (remainder num 10)))))))

  ;; Perform k transformations.
  ;; The first transformation applies to the initial-digit-string.
  ;; Subsequent transformations apply to the integer result of the previous sum.
  (let loop ([current-k k] [current-num-val (sum-digits-from-string initial-digit-string)])
    (if (= current-k 1)
        current-num-val
        (loop (- current-k 1) (sum-digits-from-integer current-num-val)))))