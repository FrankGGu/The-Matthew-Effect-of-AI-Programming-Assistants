#lang racket

(define (get-directions root start-value dest-value)
  (define (find-path node target path)
    (cond
      [(null? node) #f]
      [(= (node-val node) target) path]
      [else
       (or (find-path (node-left node) target (cons "L" path))
           (find-path (node-right node) target (cons "R" path))]))

  (define start-path (reverse (find-path root start-value '())))
  (define dest-path (reverse (find-path root dest-value '())))

  (let loop ([i 0])
    (cond
      [(or (>= i (length start-path)) (>= i (length dest-path)))
       (make-string (length (drop start-path i)) #\U)]
      [(equal? (list-ref start-path i) (list-ref dest-path i))
       (loop (add1 i))]
      [else
       (string-append
        (make-string (length (drop start-path i)) #\U)
        (apply string-append (drop dest-path i)))])))

(define (node-val node) (vector-ref node 0))
(define (node-left node) (vector-ref node 1))
(define (node-right node) (vector-ref node 2))