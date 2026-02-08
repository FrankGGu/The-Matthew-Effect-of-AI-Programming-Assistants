(define (count-senior-citizens details)
  (foldl (lambda (detail count)
           (let* ((age-str (substring detail 11 13))
                  (age (string->number age-str)))
             (if (> age 60)
                 (add1 count)
                 count)))
         0
         details))