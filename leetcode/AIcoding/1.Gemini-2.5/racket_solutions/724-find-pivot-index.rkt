(define (pivot-index nums)
  (let ([total-sum (apply + nums)])
    (let loop ([i 0] [left-sum 0] [remaining-nums nums])
      (if (empty? remaining-nums)
          -1
          (let ([current-num (car remaining-nums)])
            (let ([right-sum (- total-sum left-sum current-num)])
              (if (= left-sum right-sum)
                  i
                  (loop (+ i 1) (+ left-sum current-num) (cdr remaining-nums)))))))))