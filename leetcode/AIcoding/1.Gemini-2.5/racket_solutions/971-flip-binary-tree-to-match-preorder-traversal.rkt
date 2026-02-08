(struct TreeNode (val left right))

(define (flip-match-voyage root voyage)
  (define flips '())
  (define current-idx 0)
  (define possible #t)

  (define (dfs node)
    (when (not possible) (void))

    (when (null? node) (void))

    (when (and possible (not (null? node)))
      (when (>= current-idx (length voyage))
        (set! possible #f)
        (void))

      (when (and possible (not (equal? (TreeNode-val node) (list-ref voyage current-idx))))
        (set! possible #f)
        (void))

      (when possible
        (set! current-idx (+ current-idx 1))

        (let ((left-child (TreeNode-left node))
              (right-child (TreeNode-right node)))

          (cond
            ((and left-child right-child)
             (when (>= current-idx (length voyage))
               (set! possible #f)
               (void))

             (when possible
               (let ((next-voyage-val (list-ref voyage current-idx)))
                 (if (not (equal? (TreeNode-val left-child) next-voyage-val))
                     (begin
                       (set! flips (cons (TreeNode-val node) flips))
                       (dfs right-child)
                       (dfs left-child))
                     (begin
                       (dfs left-child)
                       (dfs right-child))))))

            (left-child
             (dfs left-child))

            (right-child
             (dfs right-child))

            (else
             (void)))))))

  (cond
    ((and (null? root) (null? voyage))
     (set! possible #t))
    ((and (null? root) (not (null? voyage)))
     (set! possible #f))
    ((and (not (null? root)) (null? voyage))
     (set! possible #f))
    (else
     (dfs root)))

  (if (not possible)
      '(-1)
      (reverse flips)))