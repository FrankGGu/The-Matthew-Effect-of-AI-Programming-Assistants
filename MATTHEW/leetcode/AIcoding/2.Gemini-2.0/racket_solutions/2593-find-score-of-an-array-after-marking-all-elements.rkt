(define (find-score nums)
  (let* ([n (length nums)]
         [marked (make-vector n #f)]
         [indexed-nums (map (lambda (i num) (cons num i)) (range n) nums)]
         [sorted-nums (sort indexed-nums < #:key car)])
    (let loop ([sorted-nums sorted-nums] [score 0])
      (if (null? sorted-nums)
          score
          (let* ([current (car sorted-nums)]
                 [num (car current)]
                 [index (cdr current)])
            (if (vector-ref marked index)
                (loop (cdr sorted-nums) score)
                (begin
                  (vector-set! marked index #t)
                  (when (> index 0) (vector-set! marked (- index 1) #t))
                  (when (< index (- n 1)) (vector-set! marked (+ index 1) #t))
                  (loop (cdr sorted-nums) (+ score num)))))))))