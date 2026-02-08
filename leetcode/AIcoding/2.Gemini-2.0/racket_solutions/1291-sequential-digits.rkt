(define (sequential-digits low high)
  (define (generate-sequential start len)
    (let loop ([curr start] [result '()])
      (if (= len 0)
          result
          (loop (+ curr 1) (append result (list curr))))))

  (define (num->list n)
    (if (= n 0)
        '()
        (cons (modulo n 10) (num->list (quotient n 10)))))

  (define (list->num lst)
    (foldl (lambda (x acc) (+ (* acc 10) x)) 0 lst))

  (define (get-digits n)
    (length (num->list n)))

  (define (find-sequential-digits low high)
    (let loop ([digits (get-digits low)] [result '()])
      (if (> digits 9)
          result
          (let* ([start-digits (map (lambda (x) (list->num (reverse (generate-sequential x digits)))) (range 1 (- 11 digits)))]
                 [valid-digits (filter (lambda (x) (and (>= x low) (<= x high))) start-digits)])
            (loop (+ digits 1) (append result valid-digits)))))

  (sort (find-sequential-digits low high) <))