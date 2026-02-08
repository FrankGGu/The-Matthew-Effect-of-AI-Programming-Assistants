(define (find-bottom-left-value root)
  (let loop ([nodes (list root)] [leftmost (car (list root))])
    (if (null? nodes)
        leftmost
        (let ([next-level (list)])
          (for ([node (in-list nodes)])
            (when (not (null? (struct-ref node 1)))
              (set! next-level (append next-level (list (struct-ref node 1)))))
            (when (not (null? (struct-ref node 2)))
              (set! next-level (append next-level (list (struct-ref node 2))))))
          (if (null? next-level)
              leftmost
              (loop next-level (struct-ref (car next-level) 0)))))))