(define (minimum-operations arr k)
  (let* ((n (length arr))
         (total-sum (foldl + 0 arr))
         (remainder (modulo total-sum k)))
    (if (= remainder 0)
        0
        (let loop ((i 0) (current-sum 0) (min-len n))
          (cond
            ((= i n)
             (if (= min-len n)
                 -1
                 min-len))
            (else
             (let* ((current-sum (+ current-sum (list-ref arr i)))
                    (current-remainder (modulo current-sum k)))
               (if (= current-remainder remainder)
                   (min (loop (+ i 1) current-sum min-len) (- n i -1))
                   (loop (+ i 1) current-sum min-len)))))))))