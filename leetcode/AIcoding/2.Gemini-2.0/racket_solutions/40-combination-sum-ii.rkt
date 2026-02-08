(define (combination-sum2 candidates target)
  (define (remove-duplicates lst)
    (cond [(null? lst) '()]
          [(member? (car lst) (cdr lst)) (remove-duplicates (cdr lst))]
          [else (cons (car lst) (remove-duplicates (cdr lst)))]))

  (define (helper lst current-sum current-combination remaining-candidates)
    (cond [(> current-sum target) '()]
          [(= current-sum target) (list (sort current-combination <))]
          [else
           (cond [(null? remaining-candidates) '()]
                 [else
                  (let* ([first-candidate (car remaining-candidates)]
                         [rest-candidates (cdr remaining-candidates)]
                         [include (helper lst (+ current-sum first-candidate) (cons first-candidate current-combination) rest-candidates)]
                         [exclude (helper lst current-sum current-combination (remove first-candidate remaining-candidates))]

                    (append include exclude)
                    ))])]))

  (remove-duplicates (helper (sort candidates <) 0 '() candidates)))