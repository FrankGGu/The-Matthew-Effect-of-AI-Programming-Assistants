(define (check-if-can-break s1 s2)
  (let* ((s1-list (sort (string->list s1) char<?))
         (s2-list (sort (string->list s2) char<?))
    (or (check-break s1-list s2-list)
        (check-break s2-list s1-list))))

(define (check-break a b)
  (for/and ((x a) (y b))
    (char<=? x y)))