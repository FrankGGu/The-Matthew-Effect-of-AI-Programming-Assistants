(define (number-of-laser-beams bank)
  (let loop ([rows bank] [prev-devices 0] [total-beams 0])
    (cond
      [(null? rows) total-beams]
      [else
       (let ([devices (string-length (filter (lambda (c) (char=? c #\1)) (string->list (car rows)))))
         (if (= devices 0)
             (loop (cdr rows) prev-devices total-beams)
             (loop (cdr rows) devices (+ total-beams (* prev-devices devices)))))])))