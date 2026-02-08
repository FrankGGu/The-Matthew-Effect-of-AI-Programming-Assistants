(define (solve n k)
  (if (= n 1)
      #\a
      (let* ([len (expt 2 (- n 1))]
             [mid (/ len 2)])
        (if (<= k mid)
            (solve (- n 1) k)
            (if (= (solve (- n 1) (- k mid)) #\a)
                #\b
                #\a)))))

(define (find-kth-character n k)
  (solve n k))