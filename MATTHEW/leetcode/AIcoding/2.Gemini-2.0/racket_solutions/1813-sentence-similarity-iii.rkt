(define (sentence-similarity-iii sentence1 sentence2)
  (define (string->list s)
    (string-split s))

  (define (prefix-match lst1 lst2)
    (cond
      [(empty? lst1) 0]
      [(empty? lst2) 0]
      [(equal? (car lst1) (car lst2)) (+ 1 (prefix-match (cdr lst1) (cdr lst2)))]
      [else 0]))

  (define (suffix-match lst1 lst2)
    (cond
      [(empty? lst1) 0]
      [(empty? lst2) 0]
      [(equal? (last lst1) (last lst2)) (+ 1 (suffix-match (drop-right lst1 1) (drop-right lst2 1)))]
      [else 0]))

  (define lst1 (string->list sentence1))
  (define lst2 (string->list sentence2))

  (let* ([len1 (length lst1)]
         [len2 (length lst2)]
         [prefix (prefix-match lst1 lst2)]
         [suffix (suffix-match (drop lst1 prefix) (drop lst2 prefix))]
         [matched (+ prefix suffix)])

    (cond
      [(and (= len1 len2) (= matched len1)) #t]
      [(and (< len1 len2) (= matched len1)) #t]
      [(and (> len1 len2) (= matched len2)) #t]
      [else #f])))