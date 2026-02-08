(define (sortPeople names heights)
  (define paired (map list heights names))
  (define sorted (sort paired (lambda (a b) (> (car a) (car b)))))
  (map cdr sorted))

(sortPeople '("Mary" "John" "Emma") '(180 165 170))