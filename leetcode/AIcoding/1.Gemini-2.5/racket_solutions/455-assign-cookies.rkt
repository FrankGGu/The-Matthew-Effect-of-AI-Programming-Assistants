(require racket/list)

(define (assign-cookies g s)
  (define sorted-g (sort g <))
  (define sorted-s (sort s <))

  (define (helper g-list s-list count)
    (cond
      [(or (empty? g-list) (empty? s-list)) count]
      [else
       (let ([current-greed (car g-list)]
             [current-size (car s-list)])
         (if (>= current-size current-greed)
             (helper (cdr g-list) (cdr s-list) (+ count 1))
             (helper g-list (cdr s-list) count)))]))

  (helper sorted-g sorted-s 0))