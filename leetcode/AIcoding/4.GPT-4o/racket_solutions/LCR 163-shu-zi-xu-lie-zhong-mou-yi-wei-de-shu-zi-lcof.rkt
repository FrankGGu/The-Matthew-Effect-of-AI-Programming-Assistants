(define (findKthDigit n k)
  (define (digit-count x)
    (if (= x 0) 1
        (truncate (log 10 (exact->inexact x)) + 1)))
  (define (count-length d)
    (if (= d 0) 1
        (if (= d 1) 1
            (+ (* 9 (expt 10 (- d 1))) (* d (expt 10 (- d 1)))))))
  (define (find-digit n k)
    (let loop ((num 1) (k k))
      (if (<= k (digit-count num))
          (substring (number->string num) (- k 1 (- (digit-count num))) (- k 1))
          (loop (+ num 1) (- k (digit-count num))))))
  (find-digit n k))

(findKthDigit 13 2)