(define (max-non-overlapping-intervals intervals)
  (let* ((sorted-intervals (sort intervals (lambda (a b) (< (cadr a) (cadr b)))))
         (n (length sorted-intervals)))
    (if (zero? n)
        0
        (let loop ((i 1) (last-end (cadr (car sorted-intervals))) (score (caddr (car sorted-intervals))))
          (if (= i n)
              score
              (let ((curr-interval (list-ref sorted-intervals i)))
                (if (>= (car curr-interval) last-end)
                    (loop (+ i 1) (cadr curr-interval) (+ score (caddr curr-interval)))
                    (loop (+ i 1) last-end score))))))))