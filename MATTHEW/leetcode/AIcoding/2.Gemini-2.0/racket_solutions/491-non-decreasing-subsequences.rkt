(define (find-subsequences nums)
  (define (helper current-subsequence remaining-nums result)
    (cond
      [(empty? remaining-nums)
       (if (>= (length current-subsequence) 2)
           (cons current-subsequence result)
           result)]
      [else
       (let* ([first-num (first remaining-nums)]
              [rest-nums (rest remaining-nums)]
              [can-extend? (or (empty? current-subsequence)
                               (>= first-num (last current-subsequence)))]
              [include-result (if can-extend?
                                  (helper (append current-subsequence (list first-num)) rest-nums result)
                                  result)]
              [exclude-result (helper current-subsequence rest-nums include-result)])
         exclude-result)]))

  (define (remove-duplicates lst)
    (define (list->string l)
      (string-join (map number->string l) ","))

    (define strings (map list->string lst))
    (define unique-strings (remove-duplicates strings))
    (map (lambda (s) (map string->number (string-split s ","))) unique-strings))

  (define result (helper '() nums '()))
  (remove-duplicates result))

(define (remove-duplicates lst)
  (define (list->string l)
    (string-join (map number->string l) ","))

  (define strings (map list->string lst))
  (define unique-strings (remove-duplicates strings))
  (map (lambda (s) (map string->number (string-split s ","))) unique-strings))

(define (remove-duplicates lst)
  (let loop ([lst lst] [seen '()] [result '()])
    (cond
      [(empty? lst) (reverse result)]
      [else
       (let ([head (first lst)]
             [tail (rest lst)])
         (let ([serialized (list->string head)])
           (if (member serialized seen)
               (loop tail seen result)
               (loop tail (cons serialized seen) (cons head result)))))])))

(define (list->string l)
  (string-join (map number->string l) ","))