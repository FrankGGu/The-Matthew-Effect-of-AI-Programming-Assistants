(define (insert-everywhere item lst)
  (let loop ((prefix '()) (suffix lst) (acc '()))
    (if (empty? suffix)
        (reverse (cons (append (reverse prefix) (list item)) acc))
        (loop (cons (car suffix) prefix)
              (cdr suffix)
              (cons (append (reverse prefix) (list item) suffix) acc)))))

(define (solution nums)
  (cond
    ((empty? nums) (list '()))
    (else
     (let* ((head (car nums))
            (tail (cdr nums))
            (perms-of-tail (solution tail)))
       (apply append
              (map (lambda (p) (insert-everywhere head p)) perms-of-tail))))))