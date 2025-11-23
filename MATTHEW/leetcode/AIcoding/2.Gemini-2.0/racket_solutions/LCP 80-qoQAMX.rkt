(define (solve n genes)
  (let loop ((i 1) (res 0))
    (cond
      ((> i n) res)
      (else
       (let ((current-gene (list-ref genes (- i 1))))
         (let ((mutation-count (length (filter (lambda (g) (not (equal? g current-gene))) genes))))
           (loop (+ i 1) (+ res mutation-count))))))))