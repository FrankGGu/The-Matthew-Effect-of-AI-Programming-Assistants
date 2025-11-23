(define (maximum-area-of-longest-diagonal-rectangle rectangles)
  (let loop ((rect-list rectangles)
             (max-diag-sq 0)
             (max-area 0))
    (if (empty? rect-list)
        max-area
        (let* ((current-rect (car rect-list))
               (l (car current-rect))
               (w (cadr current-rect))
               (current-diag-sq (+ (* l l) (* w w)))
               (current-area (* l w)))
          (cond
            ((> current-diag-sq max-diag-sq)
             (loop (cdr rect-list) current-diag-sq current-area))
            ((= current-diag-sq max-diag-sq)
             (loop (cdr rect-list) max-diag-sq (max max-area current-area)))
            (else
             (loop (cdr rect-list) max-diag-sq max-area)))))))