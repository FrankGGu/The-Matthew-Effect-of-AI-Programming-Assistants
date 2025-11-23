#lang racket

(define (evaluate-division equations values target)
  (define graph (make-hash))
  (for ([eq (in-list equations)]
        [val (in-list values)])
    (define a (car eq))
    (define b (cadr eq))
    (hash-set! graph a (cons (cons b val) (hash-ref graph a '())))
    (hash-set! graph b (cons (cons a (/ 1.0 val)) (hash-ref graph b '()))))

  (define (bfs start end)
    (define visited (make-hash))
    (define queue (list (cons start 1.0)))
    (when (not (hash-has-key? graph start)) #f)
    (let loop ()
      (when (null? queue) #f)
      (define current (car queue))
      (define node (car current))
      (define value (cdr current))
      (set! queue (cdr queue))
      (if (equal? node end)
          value
          (begin
            (hash-set! visited node #t)
            (for ([neighbor (in-list (hash-ref graph node))])
              (define n-node (car neighbor))
              (define n-val (cdr neighbor))
              (when (not (hash-has-key? visited n-node))
                (set! queue (append queue (list (cons n-node (* value n-val)))))))
            (loop)))))

  (map (lambda (eq) (bfs (car eq) (cadr eq))) target))