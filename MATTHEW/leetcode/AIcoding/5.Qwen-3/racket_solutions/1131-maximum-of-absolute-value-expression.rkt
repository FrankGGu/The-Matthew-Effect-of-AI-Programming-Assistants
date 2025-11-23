(define (max-abs-val expr)
  (let ((n (length expr)))
    (if (= n 0) 0
        (let ((max-val -inf.0))
          (for-each
           (lambda (i)
             (let ((x1 (list-ref expr i))
                   (y1 (list-ref expr (+ i 1))))
               (for-each
                (lambda (j)
                  (let ((x2 (list-ref expr j))
                        (y2 (list-ref expr (+ j 1))))
                    (set! max-val (max max-val (abs (- (+ x1 y1) (+ x2 y2)))))
                    (set! max-val (max max-val (abs (- (+ x1 (- y1)) (+ x2 (- y2))))))
                    (set! max-val (max max-val (abs (- (- x1 y1) (- x2 y2)))))
                    (set! max-val (max max-val (abs (- (- x1 (- y1)) (- x2 (- y2))))))))
                (range 0 n))))
           (range 0 n))
          max-val))))

(define (main)
  (let ((expr (read)))
    (display (max-abs-val expr))
    (newline)))

(main)