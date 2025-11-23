(define (compareVersion version1 version2)
  (define (string->number s)
    (string->number/integer s #f))

  (define (split-version v)
    (map string->number (string-split v ".")))

  (define v1 (split-version version1))
  (define v2 (split-version version2))

  (define len1 (length v1))
  (define len2 (length v2))

  (define (compare-helper i)
    (cond
      [(and (= i len1) (= i len2)) 0]
      [(= i len1)
       (if (any? (lambda (x) (> x 0)) (drop v2 i)) -1 0)]
      [(= i len2)
       (if (any? (lambda (x) (> x 0)) (drop v1 i)) 1 0)]
      [else
       (let ([n1 (list-ref v1 i)]
             [n2 (list-ref v2 i)])
         (cond
           [(> n1 n2) 1]
           [(< n1 n2) -1]
           [else (compare-helper (+ i 1))]))]))

  (compare-helper 0))