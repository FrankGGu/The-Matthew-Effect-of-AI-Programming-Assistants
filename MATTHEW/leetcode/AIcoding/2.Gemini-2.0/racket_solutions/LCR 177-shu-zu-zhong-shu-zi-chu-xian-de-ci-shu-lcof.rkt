(define (colorful-pairs colors)
  (let loop ([colors colors] [count 0])
    (cond
      [(null? colors) count]
      [else
       (let ([first-color (car colors)]
             [rest-colors (cdr colors)])
         (loop rest-colors
               (+ count
                  (length (filter (lambda (color) (not (equal? first-color color))) rest-colors)))))])))