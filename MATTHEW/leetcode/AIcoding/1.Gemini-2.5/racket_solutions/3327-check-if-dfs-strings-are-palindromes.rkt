#lang racket

(define (check-dfs-palindromes adj chars)
  (define num-nodes (vector-length chars))

  (define (palindrome? lst)
    (equal? lst (reverse lst)))

  (define (dfs node current-path)
    (let* ((node-char (vector-ref chars node))
           (new-path (append current-path (list node-char))))

      (let ((children (vector-ref adj node)))
        (if (empty? children)
            (palindrome? new-path)
            (and-map (lambda (child) (dfs child new-path)) children)))))

  (if (= num-nodes 0)
      #t
      (dfs 0 '())))