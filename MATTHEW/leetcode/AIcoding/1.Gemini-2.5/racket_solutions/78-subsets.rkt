(define (subsets nums)
  (foldl (lambda (num acc-subsets)
           (append acc-subsets
                   (for/list ([subset acc-subsets])
                     (append subset (list num)))))
         '(())
         nums))