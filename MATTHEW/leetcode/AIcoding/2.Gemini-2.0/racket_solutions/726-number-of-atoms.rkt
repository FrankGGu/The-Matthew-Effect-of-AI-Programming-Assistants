(define (count-of-atoms formula)
  (define (parse formula idx)
    (define (parse-element)
      (let loop ([i idx] [acc ""])
        (cond
          [(and (< i (string-length formula)) (char-alphabetic? (string-ref formula i)) (char-lower-case? (string-ref formula i)))
           (loop (+ i 1) (string-append acc (string (string-ref formula i))))]
          [else
           (values acc i)])))

    (define (parse-number)
      (let loop ([i idx] [acc ""])
        (cond
          [(and (< i (string-length formula)) (char-numeric? (string-ref formula i)))
           (loop (+ i 1) (string-append acc (string (string-ref formula i))))]
          [else
           (if (equal? acc "") 1 (string->number acc))
           (values (if (equal? acc "") 1 (string->number acc)) i)])))

    (define (parse-group)
      (let loop ([i idx] [counts (hash)])
        (cond
          [(>= i (string-length formula)) (values counts i)]
          [else
           (match (string-ref formula i)
             [#\( (let-values ([(sub-counts next-i)] (parse formula (+ i 1)))
                      (loop next-i (hash-update counts sub-counts (lambda (x) x (hash)))))]
             [#\) (let-values ([(num next-i)] (parse-number (+ i 1)))
                      (hash-map counts (lambda (k v) (* v num)))
                      (values counts next-i))]
             [else
              (let-values ([(element next-i)] (parse-element i))
                   (let-values ([(num next-next-i)] (parse-number next-i))
                     (loop next-next-i (hash-update counts element (lambda (x) (+ x num)) 0))))])])))

    (let loop ([i idx] [counts (hash)])
      (cond
        [(>= i (string-length formula)) counts]
        [else
         (match (string-ref formula i)
           [#\( (let-values ([(sub-counts next-i)] (parse formula (+ i 1)))
                    (loop next-i (hash-update counts sub-counts (lambda (x) x (hash)))))]
           [else
            (let-values ([(element next-i)] (parse-element i))
                 (let-values ([(num next-next-i)] (parse-number next-i))
                   (loop next-next-i (hash-update counts element (lambda (x) (+ x num)) 0))))])])))

  (define counts (parse formula 0))
  (define sorted-keys (sort (hash-keys counts) string<?))
  (string-join (map (lambda (k) (string-append k (if (= (hash-ref counts k) 1) "" (number->string (hash-ref counts k))))) sorted-keys) "")
  )