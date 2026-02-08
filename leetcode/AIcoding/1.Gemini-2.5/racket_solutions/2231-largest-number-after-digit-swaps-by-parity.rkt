(define (largest-number-after-digit-swaps-by-parity num)
  (let* ([num-str (number->string num)]
         [digits-char (string->list num-str)]
         [digits-int (map (lambda (c) (- (char->integer c) (char->integer #\0))) digits-char)]
         [parities (map (lambda (d) (if (even? d) 0 1)) digits-int)]
         [odd-digits (filter odd? digits-int)]
         [even-digits (filter even? digits-int)]
         [sorted-odd (sort odd-digits >)]
         [sorted-even (sort even-digits >)])
    (let loop ([current-parities parities]
               [current-sorted-odd sorted-odd]
               [current-sorted-even sorted-even]
               [result 0])
      (if (null? current-parities)
          result
          (let* ([parity (car current-parities)]
                 [next-digit (if (= parity 1)
                                 (car current-sorted-odd)
                                 (car current-sorted-even))]
                 [next-sorted-odd (if (= parity 1)
                                      (cdr current-sorted-odd)
                                      current-sorted-odd)]
                 [next-sorted-even (if (= parity 0)
                                       (cdr current-sorted-even)
                                       current-sorted-even)])
            (loop (cdr current-parities)
                  next-sorted-odd
                  next-sorted-even
                  (+ (* result 10) next-digit)))))))