#lang racket

(define (minimum-operations nums start goal)
  (define visited (make-hash))
  (define queue (make-queue))
  (enqueue! queue (cons start 0))
  (hash-set! visited start #t)

  (let loop ()
    (if (queue-empty? queue)
        -1
        (let* ([current (dequeue! queue)]
               [num (car current)]
               [steps (cdr current)])
          (if (= num goal)
              steps
              (begin
                (for ([next (in-list (generate-next nums num))])
                  (when (and (not (hash-ref visited next #f))
                    (hash-set! visited next #t)
                    (enqueue! queue (cons next (add1 steps)))))
                (loop)))))))

(define (generate-next nums num)
  (define nexts '())
  (for ([x (in-list nums)])
    (set! nexts (cons (+ num x) nexts))
    (set! nexts (cons (- num x) nexts))
    (set! nexts (cons (bitwise-xor num x) nexts)))
  nexts)

(define (make-queue) (mcons null null))
(define (queue-empty? q) (null? (mcar q)))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (list x)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr! q) (list x)) (set-mcdr! q (mcdr! (mcdr! q))))))
(define (dequeue! q)
  (let ([front (mcar q)])
    (set-mcar! q (cdr front))
    (when (null? (mcar q)) (set-mcdr! q null))
    (car front)))