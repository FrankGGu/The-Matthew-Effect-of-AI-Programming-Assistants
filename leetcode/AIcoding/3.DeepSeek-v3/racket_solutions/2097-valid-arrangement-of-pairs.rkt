#lang racket

(define (valid-arrangement pairs)
  (define graph (make-hash))
  (define in-degree (make-hash))
  (define out-degree (make-hash))

  (for ([pair pairs])
    (let ([u (car pair)]
          [v (cadr pair)])
      (hash-update! graph u (lambda (lst) (cons v lst)) '())
      (hash-update! out-degree u add1 0)
      (hash-update! in-degree v add1 0)))

  (define start (car (car pairs)))
  (for ([(u _) out-degree])
    (when (> (- (hash-ref out-degree u 0) (hash-ref in-degree u 0)) 0)
      (set! start u))))

  (define path '())
  (define stack (list start))

  (let loop ()
    (when (not (null? stack))
      (let ([u (car stack)])
        (if (not (null? (hash-ref graph u '())))
            (let ([v (car (hash-ref graph u))])
              (hash-set! graph u (cdr (hash-ref graph u)))
              (set! stack (cons v stack))
              (loop))
            (begin
              (set! path (cons u path))
              (set! stack (cdr stack))
              (loop))))))

  (define result '())
  (for ([i (in-range 1 (length path))])
    (set! result (cons (list (list-ref path (- (length path) i 1)) (list-ref path (- (length path) i))) result)))

  (reverse result))