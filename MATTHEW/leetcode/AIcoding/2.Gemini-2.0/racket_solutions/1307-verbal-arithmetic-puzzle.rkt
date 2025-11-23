(define (solve-verbal-arithmetic puzzle)
  (define (parse-puzzle puzzle)
    (define parts (string-split puzzle " "))
    (define words (remove-duplicates (flatten (map string->list (append (list (first parts)) (drop-right (rest parts) 2))))))
    (define operands (append (list (first parts)) (drop-right (rest parts) 2)))
    (define result (last parts))
    (values words operands result))

  (define-values (words operands result) (parse-puzzle puzzle))

  (define first-letters (list->set (map (lambda (word) (string->list word #:start 0 #:end 1)) operands)))
  (set-add! first-letters (string->list result #:start 0 #:end 1))

  (define (string-to-number str assignment)
    (string->number (list->string (map (lambda (char) (number->string (hash-ref assignment char))) (string->list str)))))

  (define (check-solution assignment)
    (let ([nums (map (lambda (operand) (string-to-number operand assignment)) operands)])
      (= (apply + nums) (string-to-number result assignment))))

  (define (solve current-assignment remaining-letters)
    (if (null? remaining-letters)
        (if (check-solution current-assignment)
            current-assignment
            #f)
        (let ([letter (car remaining-letters)])
          (for/first ([digit (in-range 0 10)]
                      #:unless (and (set-member? first-letters letter) (= digit 0))
                      #:when (not (hash-has-key? current-assignment letter))
                      #:let ([new-assignment (hash-set current-assignment letter digit)])
                      #:let ([result (solve new-assignment (cdr remaining-letters))])
                      #:when result
                      result))))

  (let ([solution (solve (hash) words)])
    (if solution
        #t
        #f)))