#lang racket

(define (max-free-time intervals)
  (define (sort-intervals intervals)
    (sort intervals (lambda (a b) (< (car a) (car b)))))

  (define (merge-intervals intervals)
    (if (null? intervals)
        '()
        (let loop ([intervals (cdr intervals)]
                   [merged (list (car intervals))])
          (if (null? intervals)
              merged
              (let* ([last (last merged)]
                     [current (car intervals)]
                     [start (car current)]
                     [end (cadr current)]
                     [last-start (car last)]
                     [last-end (cadr last)])
                (if (<= start last-end)
                    (loop (cdr intervals) (append (take merged (- (length merged) 1)) (list (list last-start (max last-end end))))
                          (loop (cdr intervals) (append merged (list current)))))))))

  (define (free-time merged)
    (if (null? merged)
        '()
        (let loop ([merged merged]
                   [result '()])
          (if (null? (cdr merged))
              result
              (let* ([current (car merged)]
                     [next (cadr merged)]
                     [current-end (cadr current)]
                     [next-start (car next)])
                (loop (cdr merged) (append result (list (- next-start current-end)))))))))

  (define sorted (sort-intervals intervals))
  (define merged (merge-intervals sorted))
  (define free (free-time merged))
  (if (null? free)
      0
      (apply max free)))