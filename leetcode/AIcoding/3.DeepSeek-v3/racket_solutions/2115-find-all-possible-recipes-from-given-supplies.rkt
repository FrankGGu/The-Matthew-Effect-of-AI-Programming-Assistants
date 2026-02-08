#lang racket

(define (find-all-recipes recipes ingredients supplies)
  (let* ([supply-set (list->set supplies)]
         [graph (make-hash)]
         [in-degree (make-hash)]
         [queue '()]
         [result '()])

    (for ([recipe recipes] [ingredient-list ingredients] [i (in-naturals)])
      (hash-set! graph recipe '())
      (hash-set! in-degree recipe (length ingredient-list))
      (for ([ingredient ingredient-list])
        (unless (set-member? supply-set ingredient)
          (hash-update! graph ingredient (lambda (lst) (cons recipe lst)) '()))

    (for ([supply supplies])
      (for ([neighbor (hash-ref graph supply '())])
        (hash-update! in-degree neighbor sub1)
        (when (zero? (hash-ref in-degree neighbor))
          (set! queue (cons neighbor queue))))

    (let loop ()
      (unless (null? queue)
        (let ([current (car queue)])
          (set! queue (cdr queue))
          (set! result (cons current result))
          (for ([neighbor (hash-ref graph current '())])
            (hash-update! in-degree neighbor sub1)
            (when (zero? (hash-ref in-degree neighbor))
              (set! queue (cons neighbor queue))))
        (loop)))

    (reverse result)))