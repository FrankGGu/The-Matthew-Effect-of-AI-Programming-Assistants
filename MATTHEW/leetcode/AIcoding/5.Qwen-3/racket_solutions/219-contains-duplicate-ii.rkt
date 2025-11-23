(define (contains-duplicate nums k)
  (define (helper seen)
    (cond [(null? nums) #f]
          [(and (member (car nums) seen) (<= (abs (- (length seen) (index-of seen (car nums)))) k)) #t]
          [else (helper (append seen (list (car nums))))]))
  (helper '()))