(define (pivot-array nums pivot)
  (let loop ((less '()) (equal '()) (greater '()) (lst nums))
    (cond
      ((null? lst) (append less equal greater))
      ((< (car lst) pivot) (loop (cons (car lst) less) equal greater (cdr lst)))
      ((= (car lst) pivot) (loop less (cons (car lst) equal) greater (cdr lst)))
      (else (loop less equal (cons (car lst) greater) (cdr lst))))))