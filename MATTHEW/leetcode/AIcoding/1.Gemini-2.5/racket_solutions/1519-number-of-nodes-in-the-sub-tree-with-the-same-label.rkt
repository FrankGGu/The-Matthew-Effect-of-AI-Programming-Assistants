(define (count-sub-trees n edges labels)
  ;; Build adjacency list
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  ;; Initialize result array
  (define ans (make-vector n 0))

  ;; DFS function
  ;; Returns a vector of 26 integers, representing counts of 'a' through 'z'
  ;; in the subtree rooted at 'u'.
  (define (dfs u parent)
    (let ((current-counts (make-vector 26 0)))
      ;; Increment count for current node's label
      (vector-set! current-counts
                   (- (char->integer (string-ref labels u)) (char->integer #\a))
                   1)

      ;; Recurse on children
      (for-each (lambda (v)
                  (when (not (= v parent))
                    (let ((child-counts (dfs v u)))
                      ;; Add child counts to current counts
                      (for ([i (in-range 26)])
                        (vector-set! current-counts i
                                     (+ (vector-ref current-counts i)
                                        (vector-ref child-counts i)))))))
                (vector-ref adj u))

      ;; Store the result for node u
      (vector-set! ans u
                   (vector-ref current-counts
                               (- (char->integer (string-ref labels u)) (char->integer #\a))))

      current-counts))

  ;; Start DFS from node 0 (root) with no parent (-1)
  (dfs 0 -1)

  ;; Return the result array
  ans)