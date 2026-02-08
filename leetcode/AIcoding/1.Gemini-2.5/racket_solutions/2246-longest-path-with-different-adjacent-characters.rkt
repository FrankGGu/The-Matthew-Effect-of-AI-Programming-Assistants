(define (longest-path-with-different-adjacent-characters parent s)
  (define n (string-length s))
  (define s-chars (string->vector s))
  (define adj (make-vector n '()))

  ;; Build adjacency list
  (for ([i (in-range 1 n)])
    (let* ([u i]
           [v (vector-ref parent i)])
      ;; Add u to v's adjacency list
      (vector-set! adj v (cons u (vector-ref adj v)))
      ;; Add v to u's adjacency list
      (vector-set! adj u (cons v (vector-ref adj u)))))

  (define max-path-length 1) ;; Initialize with at least 1 (a single node is a path of length 1)

  ;; DFS function
  ;; Returns the length of the longest path starting at `u` and going downwards
  ;; (to one of its children) such that adjacent characters are different.
  (define (dfs u p)
    (define longest-child-path 0)  ;; Length of longest valid path from a child, not including u
    (define second-longest-child-path 0) ;; Length of second longest valid path from a child, not including u

    (for ([v (vector-ref adj u)])
      (unless (= v p)
        (let ([len-from-v (dfs v u)]) ;; len-from-v is length of path v -> ...
          (when (not (char=? (vector-ref s-chars u) (vector-ref s-chars v)))
            ;; If characters are different, we can extend path u -> v -> ...
            (cond
              ((> len-from-v longest-child-path)
               (set! second-longest-child-path longest-child-path)
               (set! longest-child-path len-from-v))
              ((> len-from-v second-longest-child-path)
               (set! second-longest-child-path len-from-v)))))))

    ;; Update global max-path-length with path passing through u
    ;; This path is (longest_child_path_nodes) + u + (second_longest_child_path_nodes)
    ;; Length = longest_child-path + 1 (for u) + second_longest_child-path
    (set! max-path-length (max max-path-length (+ 1 longest-child-path second-longest-child-path)))

    ;; Return the length of the longest path starting at u and going downwards
    ;; This path is u + (longest_child_path_nodes)
    (+ 1 longest-child-path))

  ;; Start DFS from root (node 0), with -1 as its parent
  (dfs 0 -1)

  max-path-length)