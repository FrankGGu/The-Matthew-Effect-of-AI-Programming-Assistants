(define (add-strings num1 num2)
  (define (char->int c)
    (- (char->integer c) (char->integer #\0)))

  (define (int->char i)
    (integer->char (+ i (char->integer #\0))))

  (define (add-digits d1 d2 carry)
    (let* ((sum (+ d1 d2 carry))
           (digit (modulo sum 10))
           (new-carry (quotient sum 10)))
      (values digit new-carry)))

  (define (add-strings-helper num1 num2 carry result)
    (cond
      ((and (empty? num1) (empty? num2) (= carry 0))
       (string-append "" result))
      (else
       (let* ((d1 (if (empty? num1) 0 (char->int (last num1))))
              (d2 (if (empty? num2) 0 (char->int (last num2))))
              (num1-rest (if (empty? num1) '() (drop-right num1 1)))
              (num2-rest (if (empty? num2) '() (drop-right num2 1))))
         (call-with-values
             (lambda () (add-digits d1 d2 carry))
             (lambda (digit new-carry)
               (add-strings-helper num1-rest num2-rest new-carry (string-append (string (int->char digit)) result))))))))

  (add-strings-helper (string->list num1) (string->list num2) 0 ""))