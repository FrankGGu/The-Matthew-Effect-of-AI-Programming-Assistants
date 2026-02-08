#lang racket

(require racket/queue)

(define (find-if-path-exists n edges source destination)
  (if (= source destination)
      #t
      (let* ([adj (make-hash)]
             [visited (make-hash)]
             [q (make-queue)])

        (for-each (lambda (edge)
                    (let ([u (car edge)]
                          [v (cadr edge)])
                      (hash-update! adj u (lambda (lst) (cons v lst)) '())
                      (hash-update! adj v (lambda (lst) (cons u lst)) '())))
                  edges)

        (queue-enqueue! q source)
        (hash-set! visited source #t)

        (let loop ()
          (if (queue-empty? q)
              #f
              (let ([current-node (queue-dequeue! q)])
                (if (= current-node destination)
                    #t
                    (begin
                      (for-each (lambda (neighbor)
                                  (unless (hash-has-key? visited neighbor)
                                    (hash-set! visited neighbor #t)
                                    (queue-enqueue! q neighbor)))
                                (hash-ref adj current-node '()))
                      (loop))))))))