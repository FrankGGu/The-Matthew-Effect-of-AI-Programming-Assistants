(define BrowserHistory
  (lambda ()
    (define history '())
    (define current 0)

    (define (visit url)
      (set! history (append (take history current) (list url)))
      (set! current (length history)))

    (define (back steps)
      (set! current (max 0 (- current steps)))
      (list-ref history current))

    (define (forward steps)
      (set! current (min (length history) (+ current steps)))
      (if (< current (length history))
          (list-ref history current)
          ""))

    (define (get-history)
      (if (null? history)
          ""
          (list-ref history current)))

    (list visit back forward get-history)))