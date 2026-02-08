(define (shuffle nums n)
  (let* ((x-part (take nums n))
         (y-part (drop nums n)))
    (apply append
           (for/list ([x (in-list x-part)]
                      [y (in-list y-part)])
             (list x y)))))