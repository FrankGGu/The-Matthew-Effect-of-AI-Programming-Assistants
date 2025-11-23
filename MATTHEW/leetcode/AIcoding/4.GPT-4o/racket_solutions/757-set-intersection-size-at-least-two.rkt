(define (intersection-size-at-least-two intervals)
  (define sorted-intervals (sort intervals (lambda (a b) (if (= (car a) (car b)) (> (cdr a) (cdr b)) (> (car a) (car b))))))
  (define n (length sorted-intervals))
  (define count 0)
  (define last-1 0)
  (define last-2 0)

  (for ([i (in-range n)])
    (let ([start (car (list-ref sorted-intervals i))]
          [end (cdr (list-ref sorted-intervals i))])
      (when (> last-2 end)
        (set! last-1 (+ last-1 1))
        (set! last-2 (+ last-2 1))
        (set! count (+ count 1)))
      (when (and (<= last-2 end) (> last-1 end))
        (set! last-1 (+ last-1 1))
        (set! count (+ count 1)))))
  count)

(define (main)
  (intersection-size-at-least-two '((1 3) (1 4) (2 5) (3 5))))

(main)