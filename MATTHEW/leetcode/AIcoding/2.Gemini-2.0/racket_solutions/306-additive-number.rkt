(define (additive-number? s)
  (define (string-to-number str)
    (if (and (> (string-length str) 1) (equal? (string-ref str 0) #\0))
        #f
        (string->number/integer str)))

  (define (helper i j)
    (let* ((num1 (string-to-number (substring s 0 i)))
           (num2 (string-to-number (substring s i j))))
      (cond
        ((or (not num1) (not num2)) #f)
        (else
         (define (check k)
           (let* ((sum (+ num1 num2))
                  (sum-str (number->string sum))
                  (len (string-length sum-str)))
             (cond
               ((> (+ k len) (string-length s)) #f)
               ((not (equal? (substring s k (+ k len)) sum-str)) #f)
               ((equal? (+ k len) (string-length s)) #t)
               (else
                (helper-next num2 sum (+ k len))))))

         (define (helper-next n1 n2 start)
           (let* ((sum (+ n1 n2))
                  (sum-str (number->string sum))
                  (len (string-length sum-str)))
             (cond
               ((> (+ start len) (string-length s)) #f)
               ((not (equal? (substring s start (+ start len)) sum-str)) #f)
               ((equal? (+ start len) (string-length s)) #t)
               (else
                (helper-next n2 sum (+ start len))))))

         (check j))))))

  (let ((n (string-length s)))
    (for*/or ((i (in-range 1 (- n 1)))
              (j (in-range (+ i 1) n)))
      (helper i j))))