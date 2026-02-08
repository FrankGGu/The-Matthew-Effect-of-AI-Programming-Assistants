(define (max-sum-in-array nums)
  (let loop ([nums nums] [max-sum -1])
    (cond
      [(empty? nums) max-sum]
      [else
       (let ([digits (map char->number (string->list (number->string (first nums)))))
             [max-digit (apply max digits)]
             [min-digit (apply min digits)])
         (loop (rest nums)
               (foldl (lambda (num acc)
                        (let ([digits (map char->number (string->list (number->string num)))]
                              [max-digit (apply max digits)]
                              [min-digit (apply min digits)])
                          (if (= max-digit min-digit)
                              (if (= (apply max digits) (apply min (map char->number (string->list (number->string (first nums))))))
                                  (max acc (+ (first nums) num))
                                  acc)
                              acc)))
                      max-sum
                      (rest nums))))])))