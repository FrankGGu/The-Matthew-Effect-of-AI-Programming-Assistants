#lang racket

(define (calculate-time-for-type garbage travel type-char)
  (let* ((num-houses (length garbage))
         (results (for/fold ((last-house-idx -1) (collection-time 0))
                            ((house-idx (in-range num-houses))
                             (house-str (in-list garbage)))
                    (let* ((chars (string->list house-str))
                           (current-type-count (count (lambda (c) (char=? c type-char)) chars)))
                      (if (> current-type-count 0)
                          (values house-idx (+ collection-time current-type-count))
                          (values last-house-idx (+ collection-time current-type-count)))))))
    (let ((last-house-with-type (car results))
          (total-collection-time (cdr results)))
      (if (= last-house-with-type -1)
          0
          (let ((travel-time-for-type (for/sum ([i (in-range last-house-with-type)])
                                        (list-ref travel i))))
            (+ total-collection-time travel-time-for-type))))))

(define (minimum-amount-of-time-to-collect-garbage garbage travel)
  (+ (calculate-time-for-type garbage travel #\M)
     (calculate-time-for-type garbage travel #\P)
     (calculate-time-for-type garbage travel #\G)))