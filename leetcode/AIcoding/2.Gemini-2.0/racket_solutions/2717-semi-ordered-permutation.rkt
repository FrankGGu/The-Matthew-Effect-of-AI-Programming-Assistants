(define (semi-ordered-permutation nums)
  (let* ((n (length nums))
         (first-index (index-of nums 1))
         (last-index (index-of nums n)))
    (+ first-index (- n 1 last-index) (if (> first-index last-index) -1 0))))

(define (index-of lst target)
  (let loop ((i 0) (l lst))
    (cond
      [(null? l) #f]
      [(= (car l) target) i]
      [else (loop (+ i 1) (cdr l))])))