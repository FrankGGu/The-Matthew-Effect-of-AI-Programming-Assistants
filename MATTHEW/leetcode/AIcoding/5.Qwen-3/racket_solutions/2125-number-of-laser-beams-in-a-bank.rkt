(define (number-of-laser-beams bank)
  (define (count-ones s)
    (string-length (string-trim s #\0)))
  (define counts (map count-ones bank))
  (define filtered (filter (lambda (x) (> x 0)) counts))
  (if (< (length filtered) 2)
      0
      (apply + (map * filtered (cdr filtered)))))