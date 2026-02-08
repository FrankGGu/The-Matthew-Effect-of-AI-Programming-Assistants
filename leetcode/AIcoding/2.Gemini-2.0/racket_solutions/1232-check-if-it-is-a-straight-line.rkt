(define (check-straight-line coordinates)
  (define (slope p1 p2)
    (let ((dx (- (car p2) (car p1)))
          (dy (- (cadr p2) (cadr p1))))
      (cond
        ((and (= dx 0) (= dy 0)) #f)
        ((= dx 0) #f)
        (else (/ dy dx)))))

  (let ((n (length coordinates)))
    (if (<= n 2)
        #t
        (let ((s (slope (list (car (car coordinates)) (cadr (car coordinates))) (list (car (cadr coordinates)) (cadr (cadr coordinates))))))
          (if (not s)
              (let loop ((rest (cddr coordinates)))
                (cond
                  ((null? rest) #t)
                  ((= (- (car (car rest)) (car (car coordinates))) 0) #t)
                  (else #f)))
              (let loop ((rest (cdr (cdr coordinates))))
                (cond
                  ((null? rest) #t)
                  (else
                   (let ((current-slope (slope (list (car (car coordinates)) (cadr (car coordinates))) (list (car (car (cdr coordinates))) (cadr (car (cdr coordinates)))))))
                     (cond
                       ((not current-slope) #f)
                       ((not (= s current-slope)) #f)
                       (else (loop (cdr rest)))))))))))))