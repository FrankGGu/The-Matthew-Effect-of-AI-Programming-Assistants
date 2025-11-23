(define (alert-names key-name key-time)
  (define employees (make-hash))
  (for ([i (in-range (length key-name))])
    (define name (list-ref key-name i))
    (define time (list-ref key-time i))
    (hash-update! employees name (lambda (v) (cons time v)) '()))

  (define alerts '())
  (hash-for-each employees
                 (lambda (name times)
                   (define sorted-times (sort (map (lambda (t) (string->number (string-append (substring t 0 2) (substring t 3 5)))) times) <))
                   (for ([i (in-range (- (length sorted-times) 2))])
                     (when (<= (- (list-ref sorted-times (+ i 2)) (list-ref sorted-times i)) 60)
                       (set! alerts (cons name alerts))
                       (break))))
                 )

  (sort (remove-duplicates alerts) string<?))