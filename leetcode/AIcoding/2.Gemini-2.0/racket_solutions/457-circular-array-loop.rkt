(define (circular-array-loop nums)
  (define n (length nums))
  (define (next i)
    (modulo (+ i (list-ref nums i)) n))
  (define (check-loop start forward?)
    (let loop ([slow start] [fast start])
      (cond
        [(not (and (positive? (if forward? (list-ref nums slow) (- (list-ref nums slow))))
                   (positive? (if forward? (list-ref nums fast) (- (list-ref nums fast))))
                   (positive? (if forward? (list-ref nums (next fast)) (- (list-ref nums (next fast)))))))
         #f]
        [(equal? slow fast)
         (if (equal? (next slow) slow) #f #t)]
        [else
         (loop (next slow) (next (next fast)))])))

  (for/or ([i (in-range n)])
    (let ([forward? (positive? (list-ref nums i))])
      (check-loop i forward?))))