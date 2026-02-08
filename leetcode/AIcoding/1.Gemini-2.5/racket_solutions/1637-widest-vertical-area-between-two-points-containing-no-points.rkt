(define (max-width points)
  (let* ([x-coords (sort (map car points) <)]
         [n (length x-coords)])
    (if (< n 2)
        0
        (for/fold ([max-diff 0]
                   [prev-x (car x-coords)])
                  ([current-x (cdr x-coords)])
          (values (max max-diff (- current-x prev-x))
                  current-x)))))