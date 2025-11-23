(define (validateBinaryTreeNodes n leftChildren rightChildren)
  (define (dfs node visited)
    (if (or (null? node) (member node visited))
        #f
        (let ((new-visited (cons node visited)))
          (and (dfs (vector-ref leftChildren node) new-visited)
               (dfs (vector-ref rightChildren node) new-visited)))))

  (define (has-no_cycle)
    (let loop ((i 0) (visited '()))
      (if (= i n)
          #t
          (if (member i visited)
              #f
              (loop (+ i 1) (cons i visited))))))

  (if (has-no_cycle)
      (dfs 0 '())
      #f))

(define (validateBinaryTreeNodesMain n leftChildren rightChildren)
  (validateBinaryTreeNodes n leftChildren rightChildren))