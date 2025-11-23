(define (sortByBits arr)
  (define (count-ones n)
    (if (= n 0)
        0
        (+ (mod n 2) (count-ones (quotient n 2)))))
  (sort (lambda (x y)
          (let ((ones-x (count-ones x))
                (ones-y (count-ones y)))
            (if (= ones-x ones-y)
                (< x y)
                (< ones-x ones-y))))
        arr))

(sortByBits arr)