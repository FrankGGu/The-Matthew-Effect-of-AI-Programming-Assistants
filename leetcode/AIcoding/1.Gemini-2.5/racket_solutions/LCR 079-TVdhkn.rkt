(define (subsets nums)
  (if (empty? nums)
      (list (list))
      (let* ((first-elem (car nums))
             (rest-subsets (subsets (cdr nums))))
        (append rest-subsets
                (map (lambda (s) (cons first-elem s)) rest-subsets)))))