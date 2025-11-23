(define (can-be-increasing? nums)
  (define (helper nums removed?)
    (cond
      [(empty? nums) #t]
      [(empty? (cdr nums)) #t]
      [else
       (let ([first (car nums)]
             [second (car (cdr nums))])
         (cond
           [(< first second) (helper (cdr nums) removed?)]
           [(not removed?)
            (or (helper (cdr nums) #t)
                (helper (cons first (cdr (cdr nums))) #t))]
           [else #f]))]))
  (helper nums #f))