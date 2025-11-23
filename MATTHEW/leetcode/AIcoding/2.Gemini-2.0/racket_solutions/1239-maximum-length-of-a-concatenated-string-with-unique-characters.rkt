(define (maximum-length arr)
  (define (has-duplicates? s)
    (not (equal? (length s) (length (remove-duplicates (string->list s))))))

  (define (solve current-string remaining-arr)
    (cond
      [(empty? remaining-arr) (string-length current-string)]
      [else
       (let* ([first-str (first remaining-arr)]
              [rest-arr (rest remaining-arr)]
              [new-string (string-append current-string first-str)])
         (cond
           [(has-duplicates? new-string) (solve current-string rest-arr)]
           [else (max (solve new-string rest-arr) (solve current-string rest-arr))]))]))

  (solve "" arr))