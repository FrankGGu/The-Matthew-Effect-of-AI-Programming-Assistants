(define (split-list-to-parts head k)
  (define (list-length lst)
    (if (null? lst)
        0
        (+ 1 (list-length (cdr lst)))))

  (define len (list-length head))
  (define base-size (floor (/ len k)))
  (define remainder (modulo len k))

  (define (helper head k base-size remainder acc)
    (if (= k 0)
        (reverse acc)
        (let* ([current-size (+ base-size (if (> remainder 0) 1 0))]
               [next-head (if (null? head)
                              null
                              (let loop ([lst head] [count 1])
                                (if (= count current-size)
                                    (let ([next (cdr lst)])
                                      (set-cdr! lst null)
                                      next)
                                    (loop (cdr lst) (+ count 1)))))]
               [next-remainder (if (> remainder 0) (- remainder 1) remainder)])
          (helper next-head (- k 1) base-size next-remainder (cons head acc)))))

  (helper head k base-size remainder '()))