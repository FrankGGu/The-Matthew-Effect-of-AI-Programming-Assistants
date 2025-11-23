(define RecentCounter%
  (class object%
    (init-field reqs)
    (super-new)

    (set! reqs '())

    (define/public (ping t)
      (set! reqs (append reqs (list t)))
      (let loop ()
        (if (and (not (empty? reqs)) (< (car reqs) (- t 3000)))
            (begin
              (set! reqs (cdr reqs))
              (loop))))
      (length reqs))
    ))

(define (RecentCounter)
  (new RecentCounter% [reqs '()]))