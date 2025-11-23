(define (k-avoiding-array n k)
  (define (helper i res)
    (if (= i n)
        res
        (let ((next (+ (car res) 1)))
          (if (and (<= next k) (not (= next (cadr res))))
              (helper i (cons next res))
              (helper (+ i 1) (cons next res))))))
  (reverse (helper 0 '())))

(define (minimum-sum n k)
  (apply + (k-avoiding-array n k)))