(define (find-all-numbers-appearing-an-odd-number-of-times arr)
  (define (helper lst acc)
    (if (null? lst)
        acc
        (helper (cdr lst) (if (member (car lst) acc) (remove (car lst) acc) (cons (car lst) acc)))))
  (helper arr '()))

(define (find-integers-with-odd-count arr)
  (define odd-numbers (find-all-numbers-appearing-an-odd-number-of-times arr))
  (define (multiply-by-two lst)
    (map (lambda (x) (* x 2)) lst))
  (multiply-by-two odd-numbers))

(define (keep-multiplying-found-values-by-two arr)
  (define result (find-integers-with-odd-count arr))
  (foldl (lambda (x acc) (cons (* x 2) acc)) '() result))

(keep-multiplying-found-values-by-two '(5 7 5 6 7 6 7))