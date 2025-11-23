(define (interval-intersection first-list second-list)
  (letrec ((helper (lambda (first-list second-list result)
                     (cond
                       ((or (null? first-list) (null? second-list)) result)
                       (else
                        (let ((a (car first-list))
                              (b (car second-list)))
                          (let ((lo (max (car a) (car b)))
                                (hi (min (cadr a) (cadr b))))
                            (cond
                              ((> lo hi)
                               (cond
                                 ((< (cadr a) (cadr b)) (helper (cdr first-list) second-list result))
                                 (else (helper first-list (cdr second-list) result))))
                              (else
                               (let ((new-result (append result (list (list lo hi)))))
                                 (cond
                                   ((< (cadr a) (cadr b)) (helper (cdr first-list) second-list new-result))
                                   ((> (cadr a) (cadr b)) (helper first-list (cdr second-list) new-result))
                                   (else (helper (cdr first-list) (cdr second-list) new-result))))))))))))))
    (helper first-list second-list '())))