(define (max-area-of-cut-cake h w horizontalCuts verticalCuts)
  (define (get-max-diff cuts total-length)
    (let* ([all-cuts (sort (cons 0 (cons total-length cuts)) <)])
      (define (find-max-diff-recursive lst current-max)
        (if (null? (cdr lst))
            current-max
            (find-max-diff-recursive (cdr lst) (max current-max (- (cadr lst) (car lst))))))
      (find-max-diff-recursive all-cuts 0)))

  (let* ([MOD 1000000007]
         [max-h-diff (get-max-diff horizontalCuts h)]
         [max-w-diff (get-max-diff verticalCuts w)])
    (modulo (* max-h-diff max-w-diff) MOD)))