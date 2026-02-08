(define/contract (number-of-lines widths s)
  (-> (listof exact-integer?) string? (listof exact-integer?))
  (let loop ([lines 1]
             [current-width 0]
             [chars (string->list s)])
    (if (null? chars)
        (list lines current-width)
        (let* ([c (car chars)]
               [width (list-ref widths (- (char->integer c) 97))])
          (if (> (+ current-width width) 100)
              (loop (add1 lines) width (cdr chars))
              (loop lines (+ current-width width) (cdr chars)))))))