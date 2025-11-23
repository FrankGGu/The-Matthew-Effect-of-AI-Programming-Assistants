(define (num-trees n)
  (if (<= n 1)
      1
      (* (- n 1) (+ (num-trees (- n 1)) (num-trees (- n 2))))))

(define (main)
  (let ((input (read)))
    (display (num-trees input))
    (newline)))

(main)