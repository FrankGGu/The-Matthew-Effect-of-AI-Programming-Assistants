(define (maximum-number-of-string-pairs strs)
  (define (count-pairs lst)
    (let loop ((s lst) (count 0) (seen '()))
      (cond
        [(null? s) count]
        [else
         (let ((current (car s))
               (rev (string->list (string-reverse (car s)))))
           (if (memv rev seen)
               (loop (cdr s) (+ count 1) seen)
               (loop (cdr s) count (cons current seen)))))])))
  (count-pairs strs))