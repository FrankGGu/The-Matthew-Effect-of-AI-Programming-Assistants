(define (max-result nums k)
  (let* ((n (length nums))
         (dp (make-vector n 0))
         (queue (list (cons 0 0)))) ; (index . value)

    (vector-set! dp 0 (vector-ref nums 0))

    (for ((i (in-range 1 n)))
      (begin
        (when (and (not (empty? queue)) (< (car (car queue)) (- i k)))
          (set! queue (cdr queue)))

        (let ((max-prev (cdr (car queue))))
          (vector-set! dp i (+ (vector-ref nums i) max-prev)))

        (let loop ((q queue))
          (cond
            ((empty? q) (set! queue (append queue (list (cons i (vector-ref dp i))))))
            ((>= (cdr (car (last q))) (vector-ref dp i)) (set! queue (drop-right queue 1)))
            (else (set! queue (append queue (list (cons i (vector-ref dp i))))))))

        (set! queue (filter (lambda (p) (<= (car p) i)) queue))

      ))

    (vector-ref dp (- n 1))))