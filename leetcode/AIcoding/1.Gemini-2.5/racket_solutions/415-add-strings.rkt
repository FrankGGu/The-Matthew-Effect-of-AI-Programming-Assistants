(define (add-strings num1 num2)

  (define (char-to-digit c)
    (- (char->integer c) (char->integer #\0)))

  (define (digit-to-char d)
    (integer->char (+ (char->integer #\0) d)))

  (define (add-rec s1 s2 i1 i2 carry result-chars)
    (cond
      ;; Base case: no more digits to process from either string and no carry left
      ((and (< i1 0) (< i2 0) (= carry 0))
       (list->string result-chars))

      ;; Recursive step
      (else
       (define d1 (if (>= i1 0) (char-to-digit (string-ref s1 i1)) 0))
       (define d2 (if (>= i2 0) (char-to-digit (string-ref s2 i2)) 0))

       (define current-sum (+ d1 d2 carry))
       (define new-digit (modulo current-sum 10))
       (define new-carry (quotient current-sum 10))

       (add-rec s1 s2
                (- i1 1)
                (- i2 1)
                new-carry
                (cons (digit-to-char new-digit) result-chars)))))

  ;; Initial call to the recursive helper function
  ;; Start from the end of both strings, with initial carry 0 and an empty list for results
  (add-rec num1 num2
           (- (string-length num1) 1)
           (- (string-length num2) 1)
           0
           '()))