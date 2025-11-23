(define (number-of-lines widths s)
  (let loop ([lines 1] [width 0] [chars (string->list s)])
    (cond
      [(empty? chars) (list lines width)]
      [else
       (let* ([char (car chars)]
              [char-index (- (char->integer char) (char->integer #\a))]
              [char-width (list-ref widths char-index)])
         (if (> (+ width char-width) 100)
             (loop (+ lines 1) char-width (cdr chars))
             (loop lines (+ width char-width) (cdr chars))))])))