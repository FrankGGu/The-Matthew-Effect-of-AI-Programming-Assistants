#lang racket

(define (additive-number num)
  (let ((n (string-length num)))
    (when (< n 3) #f) ; An additive sequence requires at least three numbers

    (define (check-additive n1 n2 current-idx)
      (let* ((sum (+ n1 n2))
             (sum-str (number->string sum))
             (sum-len (string-length sum-str)))
        (cond
          ((> (+ current-idx sum-len) n) #f) ; sum-str would exceed num length
          ((string=? sum-str (substring num current-idx (+ current-idx sum-len)))
           (if (= (+ current-idx sum-len) n)
               #t ; Reached end of string, all matched
               (check-additive n2 sum (+ current-idx sum-len))))
          (else #f))))

    (for/or ((i (range 1 (sub1 n)))) ; i is length of first number, from 1 to n-2
      (let ((s1 (substring num 0 i)))
        (when (or (= i 1) (not (char=? (string-ref s1 0) #\0))) ; Check leading zero for s1
          (let ((n1 (string->number s1)))
            (for/or ((j (range 1 (- n i)))) ; j is length of second number, from 1 to n-i-1
              (let ((s2 (substring num i (+ i j))))
                (when (or (= j 1) (not (char=? (string-ref s2 0) #\0))) ; Check leading zero for s2
                  (let ((n2 (string->number s2)))
                    (check-additive n1 n2 (+ i j))))))))))))