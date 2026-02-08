(define (minimize-or nums)
  (define (helper nums)
    (if (null? nums)
        0
        (let* ((min-or (apply logior nums))
               (best (apply min (map (lambda (x) (helper (remove x nums))) nums))))
          (min min-or best))))
  (helper nums))

(minimize-or '(1 2 3 4))