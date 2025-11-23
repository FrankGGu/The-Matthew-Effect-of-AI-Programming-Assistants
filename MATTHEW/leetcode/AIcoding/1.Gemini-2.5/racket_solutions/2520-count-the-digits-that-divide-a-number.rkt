(define (count-digits-that-divide num)
  (let loop ((current-num num)
             (original-num num)
             (count 0))
    (if (= current-num 0)
        count
        (let* ((digit (modulo current-num 10))
               (new-count (if (and (not (= digit 0))
                                   (= (modulo original-num digit) 0))
                              (add1 count)
                              count)))
          (loop (quotient current-num 10)
                original-num
                new-count)))))