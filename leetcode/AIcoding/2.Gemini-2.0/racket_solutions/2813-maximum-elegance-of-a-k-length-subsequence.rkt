(define (max-elegance profits k)
  (let* ([sorted-profits (sort profits >)])
    (let loop ([i 0] [current-elegance 0] [selected-count 0] [selected '()] [remaining '()])
      (cond
        [(>= selected-count k)
         (let ([num-duplicates (length (filter (lambda (x) (member x remaining)) selected))])
           (+ current-elegance (* num-duplicates num-duplicates)))]
        [(empty? sorted-profits)
         (if (= selected-count k)
             (let ([num-duplicates (length (filter (lambda (x) (member x remaining)) selected))])
               (+ current-elegance (* num-duplicates num-duplicates)))
             -inf.0)]
        [else
         (let ([first-profit (car sorted-profits)]
               [rest-profits (cdr sorted-profits)])
           (max
            (loop (add1 i) (+ current-elegance first-profit) (add1 selected-count) (cons first-profit selected) remaining)
            (loop (add1 i) current-elegance selected-count selected (append remaining (list first-profit))))))])))
  (loop 0 0 0 '() '())))