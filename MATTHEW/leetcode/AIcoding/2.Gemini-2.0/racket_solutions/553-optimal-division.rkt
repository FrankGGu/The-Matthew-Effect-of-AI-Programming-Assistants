(define (optimal-division nums)
  (if (empty? nums)
      ""
      (if (= (length nums) 1)
          (number->string (first nums))
          (if (= (length nums) 2)
              (string-append (number->string (first nums)) "/" (number->string (second nums)))
              (string-append (number->string (first nums)) "/(" (string-join (map number->string (rest nums)) "/") ")")))))