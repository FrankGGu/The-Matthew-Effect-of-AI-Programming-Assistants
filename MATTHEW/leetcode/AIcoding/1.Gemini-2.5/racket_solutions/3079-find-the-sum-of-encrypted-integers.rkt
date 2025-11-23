(define (sumOfEncryptedInt nums)
  (define (encrypt-num n)
    (let loop ((current-n n)
               (max-d 0)
               (num-d 0))
      (if (= current-n 0)
          ;; Base case: current-n is 0, now construct the encrypted number
          (let loop-construct ((count num-d)
                               (res 0))
            (if (= count 0)
                res
                (loop-construct (- count 1)
                                (+ (* res 10) max-d))))
          ;; Recursive step: process digits to find max and count
          (loop (quotient current-n 10)
                (max max-d (remainder current-n 10))
                (+ num-d 1)))))

  (apply + (map encrypt-num nums)))