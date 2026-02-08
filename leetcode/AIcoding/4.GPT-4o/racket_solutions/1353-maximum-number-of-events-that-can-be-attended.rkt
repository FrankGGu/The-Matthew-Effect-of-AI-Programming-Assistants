(define (max-events events)
  (define sorted-events (sort events (λ (a b) (< (car a) (car b)))))
  (define (helper events last-end max-events-count)
    (if (null? events)
        max-events-count
        (let* ((current (car events))
               (start (car current))
               (end (cadr current)))
          (if (>= start last-end)
              (helper (cdr events) end (+ max-events-count 1))
              (helper (cdr events) last-end max-events-count)))))
  (helper sorted-events 0 0))

(max-events '((1 2) (2 3) (3 4) (3 4) (4 5)))