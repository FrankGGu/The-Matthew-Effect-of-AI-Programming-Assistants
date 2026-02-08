(define recent-counter%
  (class object%
    (inherit)
    (define queue (list))
    (define/public (ping t)
      (set! queue (append queue (list t)))
      (let loop ()
        (if (and (not (empty? queue)) (< (car queue) (- t 3000)))
            (begin
              (set! queue (cdr queue))
              (loop))))
      (length queue))
    (super-new)))

(define (make-recent-counter)
  (new recent-counter%))