(define (minimum-time-to-brew-potions time)
  (let loop ((time time) (result 0))
    (if (null? time)
        result
        (loop (cdr time) (+ result (car time))))))

(define (main)
  (let* ((input (read-line))
         (time (map string->number (string-split input))))
    (display (minimum-time-to-brew-potions time))))