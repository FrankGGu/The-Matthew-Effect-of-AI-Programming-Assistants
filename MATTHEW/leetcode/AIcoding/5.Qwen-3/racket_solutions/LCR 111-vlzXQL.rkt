#lang racket

(define (calc-equation equations values queries)
  (define graph (make-hash))
  (for ([eq equations] [val values])
    (define a (car eq))
    (define b (cadr eq))
    (hash-set! graph a (cons (cons b val) (hash-ref graph a '())))
    (hash-set! graph b (cons (cons a (/ 1.0 val)) (hash-ref graph b '()))))

  (define (bfs start end)
    (define visited (make-hash))
    (define queue (list (cons start 1.0)))
    (define (loop q)
      (cond [(null? q) #f]
            [else
             (define node (caar q))
             (define val (cdar q))
             (if (equal? node end) val
                 (begin
                   (hash-set! visited node #t)
                   (loop (append (filter (lambda (x) (not (hash-has-key? visited (car x)))) (hash-ref graph node '()))
                         (cdr q))))]))
    (loop queue))

  (map (lambda (q)
         (if (and (hash-has-key? graph (car q)) (hash-has-key? graph (cadr q)))
             (bfs (car q) (cadr q))
             -1.0))
       queries))

(define (main)
  (define equations '(("a" "b") ("b" "c")))
  (define values '(2.0 3.0))
  (define queries '(("a" "c") ("b" "a") ("a" "e") ("a" "b") ("x" "y")))
  (displayln (calc-equation equations values queries)))

(main)