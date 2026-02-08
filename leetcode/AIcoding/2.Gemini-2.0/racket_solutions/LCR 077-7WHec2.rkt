(define (sort-list head)
  (define (get-length head)
    (if (null? head)
        0
        (+ 1 (get-length (cdr head)))))

  (define (split head length)
    (if (or (null? head) (= length 0))
        (values null head)
        (let loop ([current head] [count length])
          (if (= count 1)
              (let ([next (cdr current)])
                (set-cdr! current null)
                (values head next))
              (loop (cdr current) (- count 1))))))

  (define (merge left right)
    (cond
      [(null? left) right]
      [(null? right) left]
      [else
       (if (< (car left) (car right))
           (begin
             (set-cdr! left (merge (cdr left) right))
             left)
           (begin
             (set-cdr! right (merge left (cdr right)))
             right))]))

  (define (merge-sort head)
    (if (or (null? head) (null? (cdr head)))
        head
        (let* ([len (get-length head)]
               ([mid (floor (/ len 2))]
               [(values left right) (split head mid)])
               ([sorted-left (merge-sort left)]
                [sorted-right (merge-sort right)]))
          (merge sorted-left sorted-right))))

  (merge-sort head))