(define (multiply s1 s2)
  (define (string->list s) (string->list s))
  (define (list->string lst) (list->string lst))

  (define (char->int c) (- (char->integer c) (char-integer #\0)))
  (define (int->char i) (integer->char (+ i (char-integer #\0))))

  (define (multiply-digit s d)
    (let loop ([s-lst (reverse (string->list s))]
               [carry 0]
               [result '()])
      (if (null? s-lst)
          (if (= carry 0)
              result
              (cons carry result))
          (let* ([digit (char->int (car s-lst))]
                 [product (+ (* digit d) carry)]
                 [new-digit (modulo product 10)]
                 [new-carry (quotient product 10)])
            (loop (cdr s-lst) new-carry (cons new-digit result))))))

  (define (add-lists lst1 lst2)
    (let loop ([lst1 (reverse lst1)]
               [lst2 (reverse lst2)]
               [carry 0]
               [result '()])
      (cond
        [(and (null? lst1) (null? lst2) (= carry 0)) (reverse result)]
        [(and (null? lst1) (null? lst2)) (reverse (cons carry result))]
        [(null? lst1)
         (let* ([sum (+ (car lst2) carry)]
                [new-digit (modulo sum 10)]
                [new-carry (quotient sum 10)])
           (loop '() (cdr lst2) new-carry (cons new-digit result)))]
        [(null? lst2)
         (let* ([sum (+ (car lst1) carry)]
                [new-digit (modulo sum 10)]
                [new-carry (quotient sum 10)])
           (loop (cdr lst1) '() new-carry (cons new-digit result)))]
        [else
         (let* ([sum (+ (car lst1) (car lst2) carry)]
                [new-digit (modulo sum 10)]
                [new-carry (quotient sum 10)])
           (loop (cdr lst1) (cdr lst2) new-carry (cons new-digit result)))])))

  (define (remove-leading-zeros lst)
    (cond
      [(null? lst) '()]
      [(= (car lst) 0) (remove-leading-zeros (cdr lst))]
      [else lst]))

  (if (or (equal? s1 "0") (equal? s2 "0"))
      "0"
      (let loop ([s2-lst (reverse (string->list s2))]
                 [multiplier 0]
                 [results '()])
        (if (null? s2-lst)
            (let* ([final-result (foldl add-lists '(0) results)]
                   [trimmed-result (remove-leading-zeros final-result)])
              (if (null? trimmed-result)
                  "0"
                  (list->string (map int->char trimmed-result))))
            (let* ([digit (char->int (car s2-lst))]
                   [multiplied-list (multiply-digit s1 digit)]
                   [padded-list (append multiplied-list (make-list multiplier 0))])
              (loop (cdr s2-lst) (+ multiplier 1) (cons padded-list results)))))))