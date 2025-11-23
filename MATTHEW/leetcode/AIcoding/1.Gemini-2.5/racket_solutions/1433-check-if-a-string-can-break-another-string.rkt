(require racket/list)

(define (check-if-string-can-break-another-string s1 s2)
  (define s1-chars (sort (string->list s1) char<=?))
  (define s2-chars (sort (string->list s2) char<=?))

  (define (can-break? l1 l2)
    (andmap char>=? l1 l2))

  (or (can-break? s1-chars s2-chars)
      (can-break? s2-chars s1-chars)))