(define (three-sum-closest nums target)
  (define sorted-nums-list (sort nums <))
  (define sorted-nums (list->vector sorted-nums-list))
  (define n (vector-length sorted-nums))

  (define closest-sum (+ (vector-ref sorted-nums 0)
                         (vector-ref sorted-nums 1)
                         (vector-ref sorted-nums 2)))

  (call/ec
   (lambda (return)
     (for ([i (in-range (- n 2))])
       (define left (+ i 1))
       (define right (- n 1))

       (let loop ([l left] [r right])
         (when (< l r)
           (define current-sum (+ (vector-ref sorted-nums i)
                                  (vector-ref sorted-nums l)
                                  (vector-ref sorted-nums r)))

           (when (< (abs (- target current-sum))
                    (abs (- target closest-sum)))
             (set! closest-sum current-sum))

           (cond
             ((< current-sum target) (loop (+ l 1) r))
             ((> current-sum target) (loop l (- r 1)))
             (else ; current-sum == target
              (return target)))))))
  closest-sum)