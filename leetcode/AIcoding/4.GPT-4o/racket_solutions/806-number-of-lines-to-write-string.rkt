(define (number-of-lines widths s)
  (define total-width 0)
  (define lines 1)
  (for-each (lambda (char)
              (let ((width (vector-ref widths (char->integer char) -97)))
                (if (+ total-width width) > 100
                    (begin
                      (set! lines (+ lines 1))
                      (set! total-width width))
                    (set! total-width (+ total-width width)))))
            s)
  (list lines total-width))