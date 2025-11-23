#lang racket

(define (valid-path n edges source destination)
  (let ([adj (make-vector n '())])
    (for ([edge edges])
      (let ([u (car edge)]
            [v (cadr edge)])
        (vector-set! adj u (cons v (vector-ref adj u)))
        (vector-set! adj v (cons u (vector-ref adj v)))))

    (let ([visited (make-vector n #f)]
          [queue (make-queue)])
      (enqueue! queue source)
      (vector-set! visited source #t)
      (let loop ()
        (if (queue-empty? queue)
            #f
            (let ([current (dequeue! queue)])
              (if (= current destination)
                  #t
                  (begin
                    (for ([neighbor (vector-ref adj current)])
                      (when (not (vector-ref visited neighbor))
                        (vector-set! visited neighbor #t)
                        (enqueue! queue neighbor)))
                    (loop)))))))))

(define (make-queue) (mcons '() '()))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (list x)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr q) (list x)) (set-mcdr! q (mcdr (mcdr q))))))
(define (dequeue! q)
  (let ([front (caar (mcar q))])
    (set-mcar! q (cdr (mcar q)))
  front)
(define (queue-empty? q) (null? (mcar q)))