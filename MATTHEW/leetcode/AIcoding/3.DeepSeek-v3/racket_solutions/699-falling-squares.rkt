(define/contract (falling-squares positions)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (let loop ([squares positions]
             [intervals '()]
             [max-h 0]
             [res '()])
    (if (null? squares)
        (reverse res)
        (let* ([square (car squares)]
               [left (car square)]
               [size (cadr square)]
               [right (+ left size)]
               [base-h 0])
          (for ([int intervals])
            (let ([int-left (car int)]
                  [int-right (cadr int)]
                  [int-h (caddr int)])
              (when (and (< int-left right) (> int-right left))
                (set! base-h (max base-h int-h)))))
          (let ([new-h (+ base-h size)]
                [new-intervals (cons (list left right new-h) intervals)])
            (loop (cdr squares)
                  new-intervals
                  (max max-h new-h)
                  (cons (max max-h new-h) res)))))))