(define (find-score nums)
  (let* ([n (length nums)]
         [marked (make-vector n #f)]
         [heap (make-heap (lambda (a b) (if (= (car a) (car b))
                                           (< (cdr a) (cdr b))
                                           (< (car a) (car b)))))])
    (for ([i (in-range n)] [num nums])
      (heap-add! heap (cons num i)))
    (let loop ([score 0])
      (if (heap-empty? heap)
          score
          (let* ([current (heap-remove-min! heap)]
                 [val (car current)]
                 [idx (cdr current)])
            (if (vector-ref marked idx)
                (loop score)
                (begin
                  (vector-set! marked idx #t)
                  (when (> idx 0)
                    (vector-set! marked (- idx 1) #t))
                  (when (< idx (- n 1))
                    (vector-set! marked (+ idx 1) #t))
                  (loop (+ score val)))))))))