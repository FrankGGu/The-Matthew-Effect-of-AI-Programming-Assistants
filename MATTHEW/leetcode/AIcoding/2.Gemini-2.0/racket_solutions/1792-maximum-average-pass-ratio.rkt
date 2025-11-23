(define (max-average-ratio classes extra-students)
  (let loop ((classes (sort classes (lambda (a b) (< (/ (- (car b) (cadr b)) (+ 1 (cadr b)))) (/ (- (car a) (cadr a)) (+ 1 (cadr a))))))
             (extra extra-students)
             (total 0))
    (cond
      ((= extra 0)
       (for ([c classes])
         (set! total (+ total (/ (car c) (cadr c)))))
       (/ total (length classes)))
      (else
       (let ((best-class (car classes))
             (rest-classes (cdr classes)))
         (loop (cons (list (+ 1 (car best-class)) (+ 1 (cadr best-class))) rest-classes) (- extra 1) 0))))))