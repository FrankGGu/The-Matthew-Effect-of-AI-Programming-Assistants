(define (max-total-cost nums)
  (define n (length nums))
  (if (zero? n)
      0
      (let loop ([i 1] [prev-sign (if (> (list-ref nums 0) 0) 1 -1)] [current-sum (list-ref nums 0)])
        (if (= i n)
            current-sum
            (let* ([num (list-ref nums i)]
                   [sign (if (> num 0) 1 -1)])
              (if (= sign prev-sign)
                  (loop (+ i 1) prev-sign (max current-sum num))
                  (loop (+ i 1) sign (+ current-sum num))))))))