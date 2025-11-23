#lang racket

(define (ladder-length begin-word end-word word-list)
  (define word-set (list->set word-list))
  (define (neighbors word)
    (for/list ([c (in-range 97 123)]
               [i (in-range (string-length word))])
      (define lst (string->list word))
      (list-set lst i (integer->char c))
      (list->string lst)))
  (define (bfs queue visited)
    (cond [(null? queue) 0]
          [else
           (define current (caar queue))
           (define steps (cdar queue))
           (if (equal? current end-word)
               steps
               (let ([next-queue (append (filter (lambda (w) (not (set-member? visited w))) (neighbors current)) '())])
                 (bfs (append (map (lambda (w) (cons w (+ steps 1))) next-queue) (cdr queue))
                      (set-add visited current))))]))
  (if (not (set-member? word-set end-word))
      0
      (bfs (list (cons begin-word 1)) (set))))

(define (main)
  (define input (read-line))
  (define begin-word (car (string-split input #\space)))
  (define end-word (cadr (string-split input #\space)))
  (define word-list (cdr (string-split input #\space)))
  (display (ladder-length begin-word end-word word-list)))

(main)