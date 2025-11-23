(define (find-min-arrow-shots points)
  (if (null? points)
      0
      (let* ((sorted-points (sort points (lambda (a b) (< (car a) (car b)))))
             (arrows 1)
             (end (cadr (car sorted-points))))
        (for ([p (in-list (cdr sorted-points))])
          (if (> (car p) end)
              (begin
                (set! arrows (+ arrows 1))
                (set! end (cadr p)))
              (set! end (min end (cadr p)))))
        arrows)))