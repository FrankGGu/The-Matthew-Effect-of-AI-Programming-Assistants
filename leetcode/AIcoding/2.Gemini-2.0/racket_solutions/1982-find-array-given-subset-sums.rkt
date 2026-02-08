(define (recoverArray nums)
  (let loop ([nums (sort nums <)]
             [res '()])
    (cond
      [(empty? nums) (reverse res)]
      [else
       (let* ([zero (car nums)]
              [half (cdr nums)]
              [diff (- (car (cdr nums)) zero)]
              [pos '()]
              [neg '()])
         (for ([n half])
           (if (member (if (<= n (+ zero diff)) (+ n diff) (- n diff)) half)
               (begin
                 (set! pos (cons n pos))
                 (set! neg (cons (if (<= n (+ zero diff)) (+ n diff) (- n diff)) neg)))
               (begin
                 (set! pos (cons (- n diff) pos))
                 (set! neg (cons n neg)))))
         (if (zero? diff)
             (loop (cdr nums) res)
             (if (member zero pos)
                 (loop (remove-duplicates pos) (cons diff res))
                 (loop (remove-duplicates neg) (cons (- diff) res)))))])))