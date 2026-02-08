(define (solve-equation equation)
  (define (parse-side side)
    (define (parse-term str)
      (cond
        [(string=? str "") '(0 0)]
        [(string=? str "x") '(1 1)]
        [(string=? str "-x") '(-1 1)]
        [(string=? str "+x") '(1 1)]
        [(regexp-match? #rx"^[+-]?\\d+$" str) (list 0 (string->number str))]
        [(regexp-match? #rx"^[+-]?\\d+x$" str)
         (let [(coeff (string->number (substring str 0 (- (string-length str) 1))))]
           (list coeff 0))]
        [else (error "Invalid term: " str)]))

    (define (split-terms str)
      (let loop ([s str] [acc '()])
        (cond
          [(string=? s "") (reverse acc)]
          [(regexp-match? #rx"^\\+" s) (loop (substring s 1) acc)]
          [(regexp-match? #rx"^-" s)
           (let [(next-plus-minus (regexp-match #rx"^[^-+]*[-+]" s))]
             (if next-plus-minus
                 (let [(match (car next-plus-minus))
                       (term (substring s 0 (string-length match)))]
                   (loop (substring s (string-length match)) (cons term acc)))
                 (cons s acc)))]
          [else
           (let [(next-plus-minus (regexp-match #rx"^[^-+]*[-+]" s))]
             (if next-plus-minus
                 (let [(match (car next-plus-minus))
                       (term (substring s 0 (string-length match)))]
                   (loop (substring s (string-length match)) (cons term acc)))
                 (cons s acc)))])))

    (define terms (split-terms side))
    (define (sum-terms terms)
      (foldl (lambda (term acc)
               (let [(parsed-term (parse-term term))]
                 (list (+ (car acc) (car parsed-term))
                       (+ (cadr acc) (cadr parsed-term)))))
             '(0 0)
             terms))
    (sum-terms terms))

  (let* [(sides (string-split equation "="))
         (left-side (car sides))
         (right-side (cadr sides))
         (left-coeffs (parse-side left-side))
         (right-coeffs (parse-side right-side))
         (x-coeff (- (car left-coeffs) (car right-coeffs)))
         (constant (- (cadr right-coeffs) (cadr left-coeffs)))]
    (cond
      [(= x-coeff 0)
       (if (= constant 0)
           "Infinite solutions"
           "No solution")]
      [else
       (string-append "x=" (number->string (/ constant x-coeff)))])))