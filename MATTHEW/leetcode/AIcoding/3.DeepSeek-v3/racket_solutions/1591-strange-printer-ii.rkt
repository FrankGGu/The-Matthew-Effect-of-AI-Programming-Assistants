#lang racket

(define (is-printable target-grid)
  (define m (length target-grid))
  (define n (if (zero? m) 0 (length (car target-grid))))
  (define color-bounds (make-hash))

  (for* ([i (in-range m)]
         [j (in-range n)])
    (define color (list-ref (list-ref target-grid i) j))
    (when (not (hash-has-key? color-bounds color))
      (hash-set! color-bounds color (list i j i j)))
    (define bounds (hash-ref color-bounds color))
    (hash-set! color-bounds color
               (list (min (first bounds) i)
                     (min (second bounds) j)
                     (max (third bounds) i)
                     (max (fourth bounds) j))))

  (define graph (make-hash))
  (for* ([(color bounds) (in-hash color-bounds)]
         [i (in-range (first bounds) (add1 (third bounds)))]
         [j (in-range (second bounds) (add1 (fourth bounds)))])
    (define current-color (list-ref (list-ref target-grid i) j))
    (when (not (equal? current-color color))
      (hash-update! graph current-color (lambda (lst) (cons color lst)) (lambda () '()))))

  (define in-degree (make-hash))
  (for* ([(color _) (in-hash color-bounds)])
    (hash-set! in-degree color 0))

  (for* ([(color dependencies) (in-hash graph)]
         [dep (in-list dependencies)])
    (hash-update! in-degree dep add1 0))

  (define queue (make-queue))
  (for* ([(color deg) (in-hash in-degree)]
         #:when (zero? deg))
    (enqueue! queue color))

  (define processed 0)
  (let loop ()
    (if (queue-empty? queue)
        (= processed (hash-count color-bounds))
        (let ([current (dequeue! queue)])
          (set! processed (add1 processed))
          (for ([neighbor (hash-ref graph current '())])
            (hash-update! in-degree neighbor sub1)
            (when (zero? (hash-ref in-degree neighbor))
              (enqueue! queue neighbor)))
          (loop)))))

(define (make-queue) (mcons null null))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (mcons x null)) (set-mcdr! q (mcar q)))
      (let ([new (mcons x null)])
        (set-mcdr! (mcdr q) new)
        (set-mcdr! q new)))
(define (dequeue! q)
  (let ([front (mcar q)])
    (set-mcar! q (mcdr front))
    (when (null? (mcar q)) (set-mcdr! q null))
    (mcar front)))
(define (queue-empty? q) (null? (mcar q)))