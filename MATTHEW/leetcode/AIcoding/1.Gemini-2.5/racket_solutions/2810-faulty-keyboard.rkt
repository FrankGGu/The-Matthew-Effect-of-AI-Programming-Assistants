(define (faulty-keyboard s)
  (let-values (((final-front final-back final-is-reversed?)
                (foldl
                 (lambda (char current-state)
                   (let-values (((front back is-reversed?) current-state))
                     (if (char=? char #\i)
                         (list front back (not is-reversed?))
                         (if is-reversed?
                             (list (cons char front) back is-reversed?)
                             (list front (cons char back) is-reversed?)))))
                 (list '() '() #f)
                 (string->list s))))
    (let* ((result-list
            (if final-is-reversed?
                (append final-back (reverse final-front))
                (append final-front (reverse final-back)))))
      (list->string result-list))))