(define (permute-unique nums)
  (let ((n (length nums)))
    (define (helper current-permutation remaining-nums used)
      (cond
        ((null? remaining-nums)
         (list current-permutation))
        (else
         (let loop ((remaining remaining-nums)
                    (index 0)
                    (result '()))
           (cond
             ((null? remaining)
              result)
             (else
              (let ((num (car remaining)))
                (if (and (not (member num (map car (filter (lambda (x) (not (car x))) (zip remaining-nums used)))))
                         )
                    (append result
                            (helper (append current-permutation (list num))
                                    (append (take remaining-nums index) (drop remaining-nums (+ index 1)))
                                    (append (take used index) (list #t) (drop used (+ index 1)))))
                    result)
                (loop (cdr remaining) (+ index 1) result))))))))
    (remove-duplicates (helper '() nums (make-list n #f)) equal?)))