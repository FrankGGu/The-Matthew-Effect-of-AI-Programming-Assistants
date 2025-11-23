#lang racket

(define (ladder-length begin-word end-word word-list)
  (define word-set (list->set word-list))
  (define (build-graph)
    (for/fold ([graph '()]) ([word (in-list (cons begin-word (set->list word-set)))])
      (append graph (for/list ([other (in-list (cons begin-word (set->list word-set)))])
                      (if (equal? word other) '()
                          (if (= 1 (string-distance word other)) (list word other) '()))))))

  (define (string-distance s1 s2)
    (define len (min (string-length s1) (string-length s2)))
    (for/sum ([i (in-range len)])
      (if (char=? (string-ref s1 i) (string-ref s2 i)) 0 1)))

  (define graph (build-graph))

  (define (bfs start end)
    (define (helper queue visited paths)
      (cond [(null? queue) '()]
            [else
             (define current (caar queue))
             (define path (cadar queue))
             (if (equal? current end)
                 (list path)
                 (let ([next-nodes (filter (lambda (x) (not (set-member? visited x))) (map cadr (filter (lambda (x) (equal? (car x) current)) graph)))])
                   (append (helper (append (map (lambda (n) (list n (append path (list n)))) next-nodes) (cdr queue))
                                  (set-add visited current)
                                  (append paths (map (lambda (n) (append path (list n))) next-nodes))))])))
    (helper (list (list start (list start))) (set) '()))

  (define result (bfs begin-word end-word))
  (if (null? result) '() (length (car result))))

(define (main)
  (define input (current-input-port))
  (define lines (port->lines input))
  (define begin-word (list-ref lines 0))
  (define end-word (list-ref lines 1))
  (define word-list (string-split (list-ref lines 2) #\,))
  (displayln (ladder-length begin-word end-word word-list)))

(main)