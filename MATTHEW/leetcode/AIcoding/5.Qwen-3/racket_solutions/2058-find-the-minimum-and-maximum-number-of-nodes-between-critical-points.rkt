(define (nodes-between-critical-points head)
  (define (helper prev curr index res)
    (if (or (not curr) (not (cdr curr)))
        (if (null? res)
            -1
            (apply - (reverse res)))
        (let* ((next (cdr curr))
               (is-critical (and prev (or (< (car prev) (car curr) (car next)) (> (car prev) (car curr) (car next)))))
               (new-res (if is-critical
                            (cons index res)
                            res)))
          (helper curr next (+ index 1) new-res))))
  (helper #f head 0 '()))