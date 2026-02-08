(define (insert-interval intervals new-interval)
  (define (merge-intervals a b)
    (list (min (car a) (car b)) (max (cadr a) (cadr b))))

  (define merged '())
  (define i 0)
  (define n (length intervals))

  (while (< i n)
    (let ((current (list-ref intervals i)))
      (cond
        ((> (cadr new-interval) (car current))
         (if (>= (car new-interval) (cadr current))
             (begin (set! new-interval (merge-intervals new-interval current))
                    (set! i (+ i 1)))
             (begin (set! merged (append merged (list new-interval)))
                    (set! new-interval current)
                    (set! i (+ i 1)))))
        (else
         (begin (set! merged (append merged (list current)))
                (set! i (+ i 1)))))))

  (set! merged (append merged (list new-interval)))
  merged)

(define (insert intervals new-interval)
  (insert-interval intervals new-interval))