(define (find-maximum-length-valid-subsequence-ii nums k)
  (define (solve nums k index current-subsequence)
    (cond
      [(>= index (length nums))
       (if (valid-subsequence? current-subsequence k)
           (length current-subsequence)
           0)]
      [else
       (max (solve nums k (+ index 1) current-subsequence)
            (solve nums k (+ index 1) (append current-subsequence (list (list-ref nums index)))))]))

  (define (valid-subsequence? subsequence k)
    (cond
      [(<= (length subsequence) 1) #t]
      [else
       (let loop ([lst subsequence])
         (cond
           [(null? (cdr lst)) #t]
           [else
            (if (>= (* (car lst) k) (cadr lst))
                (loop (cdr lst))
                #f)]))]))
  (solve nums k 0 '()))