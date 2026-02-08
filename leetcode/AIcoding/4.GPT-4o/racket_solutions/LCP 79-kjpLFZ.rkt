(define (min-magic spells)
  (define (helper spells n)
    (if (zero? n) 0
        (let ((min-spell (apply min (map (lambda (s) (if (>= s 1) s +inf.0)) spells))))
          (if (= min-spell +inf.0) +inf.0
              (+ min-spell (helper (filter (lambda (s) (> s min-spell)) spells) (- n 1)))))))
  (helper spells (length spells)))

(define (min-magic-main spells)
  (min-magic (map (lambda (x) (string->number x)) (string-split spells))))