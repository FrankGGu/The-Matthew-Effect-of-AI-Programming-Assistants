(define (reformat-number number)
  (let* ((digits (filter char-numeric? (string->list number)))
         (n (length digits))
    (let loop ((digits digits) (result '()) (count 0))
      (cond
        ((null? digits) (list->string (reverse result)))
        ((and (= (remainder (- n count) 4) 0) (> (- n count) 0))
         (if (or (= count 0) (null? (cdr digits)))
             (loop (cdr digits) (cons (car digits) result) (+ count 1))
             (loop digits (cons #\- result) count)))
        (else
         (loop (cdr digits) (cons (car digits) result) (+ count 1)))))))