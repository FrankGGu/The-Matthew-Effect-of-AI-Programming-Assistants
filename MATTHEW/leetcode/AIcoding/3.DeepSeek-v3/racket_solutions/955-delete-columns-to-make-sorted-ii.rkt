(define (min-deletion-size strs)
  (define n (length strs))
  (define m (if (null? strs) 0 (string-length (car strs))))
  (define deleted 0)
  (define sorted (make-list n ""))

  (for ([col (in-range m)])
    (define current (map (lambda (s) (string-ref s col)) strs))
    (define new-sorted (map string-append sorted (map string current)))
    (if (sorted? new-sorted)
        (set! sorted new-sorted)
        (set! deleted (add1 deleted))))
  deleted)

(define (sorted? lst)
  (cond [(null? lst) #t]
        [(null? (cdr lst)) #t]
        [(string<=? (car lst) (cadr lst)) (sorted? (cdr lst))]
        [else #f]))