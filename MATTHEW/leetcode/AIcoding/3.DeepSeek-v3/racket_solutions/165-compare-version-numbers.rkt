(define (compare-version version1 version2)
  (let ((v1 (map string->number (string-split version1 ".")))
        (v2 (map string->number (string-split version2 "."))))
    (let loop ((l1 v1) (l2 v2))
      (cond
        [(and (null? l1) (null? l2)) 0]
        [(null? l1) (if (any positive? l2) -1 0)]
        [(null? l2) (if (any positive? l1) 1 0)]
        [else
         (let ((n1 (car l1)) (n2 (car l2)))
           (cond
             [(< n1 n2) -1]
             [(> n1 n2) 1]
             [else (loop (cdr l1) (cdr l2))]))]))))

(define (any pred lst)
  (if (null? lst)
      #f
      (or (pred (car lst)) (any pred (cdr lst)))))