(define (num-squares n)
  (define (bfs)
    (let loop ([queue (list (cons n 0))] [visited (set)])
      (if (null? queue)
          #f
          (let* ([current (car queue)]
                 [num (car current)]
                 [steps (cdr current)])
            (if (= num 0)
                steps
                (loop (append (filter (lambda (x) (not (set-member? visited x)))
                                     (map (lambda (i) (- num (* i i)))
                                          (range 1 (add1 (floor (sqrt num))) 1)))
                      (set-add visited num)))))))
  (bfs))