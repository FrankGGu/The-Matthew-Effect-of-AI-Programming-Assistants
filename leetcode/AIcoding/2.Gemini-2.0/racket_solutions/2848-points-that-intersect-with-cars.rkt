(define (number-of-points intervals)
  (define (union-intervals intervals)
    (if (null? intervals)
        '()
        (let loop ((intervals (sort intervals (lambda (a b) (< (car a) (car b)))))
                   (result '()))
          (cond
            [(null? intervals) (reverse result)]
            [(null? (cdr intervals)) (reverse (cons (car intervals) result))]
            [else
             (let ((current (car intervals))
                   (next (cadr intervals)))
               (if (<= (cadr current) (car next))
                   (loop (cdr intervals) (cons current result))
                   (loop (cons (list (car current) (max (cadr current) (cadr next))) (cddr intervals)) result))))])))

  (define merged-intervals (union-intervals intervals))
  (foldl (lambda (interval acc) (+ acc (- (cadr interval) (car interval) -1))) 0 merged-intervals))